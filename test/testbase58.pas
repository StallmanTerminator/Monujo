UNIT TestBase58;

{$mode objfpc}{$H+}

INTERFACE

USES
        sysutils, fpcunit, testutils, base58;

TYPE
        TTestBase58 = CLASS(TTestCase)
        PUBLISHED
                PROCEDURE Encode;
        END;

IMPLEMENTATION

PROCEDURE TTestBase58.Encode;
VAR
        data: pchar;
BEGIN
        data := '00000000000000000000000000000000';
        AssertEquals('4F7BsTMVPKFshM1MwLf6y23cid6fL3xMpazVoF9krzUw', Base58Encode(data));
END;

END.
