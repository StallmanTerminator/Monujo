(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT wallet;

{$mode objfpc}{$H+}

INTERFACE

USES
        sysutils,
        crypto,
        base58,
        checksum,
        sodium;

TYPE
        TWallet = CLASS
        STRICT PRIVATE
                _seed: pchar;
                _pk: pchar;
                _sk: pchar;
                _opened: boolean;
                _addr: string;
                _checksum: string;

                PROCEDURE LoadFromSeed;
        PUBLIC
                CONSTRUCTOR Create; virtual;
                DESTRUCTOR Destroy; override;

                PROPERTY Address: string read _addr;
                PROPERTY Checksum: string read _checksum;
                PROPERTY IsOpen: boolean read _opened;

                FUNCTION Load(path: string): Boolean;
                PROCEDURE Generate;
                FUNCTION Save(path: string): Boolean;
        END;

IMPLEMENTATION
        CONSTRUCTOR TWallet.Create;
        BEGIN
                _seed := StrAlloc(32);
                _pk := StrAlloc(32);
                _sk := StrAlloc(32);
                _opened := False;
        END;

        PROCEDURE TWallet.LoadFromSeed;
        BEGIN
                crypto_sign_seed_keypair(_pk, _sk, _seed);
                _addr := Base58Encode(_pk);
                _checksum := CalculateChecksum(_pk);
                _opened := True;
        END;

        FUNCTION TWallet.Load(path: string): Boolean;
        VAR
                fp: file of char;
                data: array[0..31] of char;
                i: integer;
        BEGIN
                AssignFile(fp, path);
                reset(fp);
                blockread(fp, data, 32);
                FOR i := 0 TO 31 DO
                        _seed[i] := data[i];
                CloseFile(fp);
                LoadFromSeed;
                Result := True;
        END;

        PROCEDURE TWallet.Generate;
        BEGIN
                GenerateSeed(_seed);
                LoadFromSeed;
        END;

        FUNCTION TWallet.Save(path: string): Boolean;
	VAR
		fp: file of char;
		data: array[0..31] of char;
		i: integer;
        BEGIN
		AssignFile(fp, path);
		rewrite(fp);
		FOR i := 0 TO 31 DO
			data[i] := _seed[i];
		blockwrite(fp, data, 32);
		CloseFile(fp);
                Result := True;
        END;

        DESTRUCTOR TWallet.Destroy;
        BEGIN
                StrDispose(_seed);
                StrDispose(_pk);
                StrDispose(_sk);
        END;
END.
