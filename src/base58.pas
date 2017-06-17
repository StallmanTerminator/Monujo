(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT base58;

{$mode objfpc}{$H+}

INTERFACE

USES
	strutils,
	gmp,
        sysutils;

FUNCTION Base58Encode(const data: pchar): string;

CONST
	B58_ALPHABET: shortstring = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'; 

IMPLEMENTATION

FUNCTION RawToHexString(const data: pchar): string;
BEGIN
        SetLength(Result, 64);
        BinToHex(@data[0], @Result[1], 32);
END;

FUNCTION Base58Encode(const data: pchar): string;
VAR
        hexstring: string;
        num: mpz_t;
	tmp: mpz_t;
	divisor: mpz_t;
	i: LongInt;
	res: shortstring;
BEGIN
	mpz_init(tmp);
	mpz_init(num);
	mpz_init_set_ui(divisor, 58);

        hexstring := RawToHexString(data);
	res := '';

	mpz_set_str(num, pchar(hexstring), 16);
	WHILE (mpz_cmp_ui(num, 0) > 0) DO
        BEGIN
		mpz_mod(tmp, num, divisor);
		i := mpz_get_ui(tmp);
		res := Copy(B58_ALPHABET, i + 1, 1) + res;
		mpz_fdiv_q(num, num, divisor);
        END;
	FOR i := 0 TO 32 DO
	BEGIN
		IF data[i] = chr(0)
		THEN res := Copy(B58_ALPHABET, 0, 1) + res
		ELSE BREAK;
	END;
	mpz_clear(tmp);
	mpz_clear(num);
	mpz_clear(divisor);
	result := res;
END;

END.
