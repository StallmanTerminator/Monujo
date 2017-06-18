(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT TestWallet;

{$mode objfpc}{$H+}

INTERFACE

USES
        sysutils, fpcunit, testutils, wallet;

TYPE
        TTestWallet = CLASS(TTestCase)
	PRIVATE
		fwallet: TWallet;
	PROTECTED
		PROCEDURE SetUp; OVERRIDE;
		PROCEDURE TearDown; OVERRIDE;
        PUBLISHED
                PROCEDURE TestSaveAndLoad;
        END;

IMPLEMENTATION

PROCEDURE TTestWallet.SetUp;
BEGIN
	fwallet := TWallet.Create;
	fwallet.Generate;
END;

PROCEDURE TTestWallet.TearDown;
BEGIN
	(*fwallet.Destroy;*)
END;

PROCEDURE TTestWallet.TestSaveAndLoad;
VAR
        previousAddr: string;
BEGIN
	previousAddr := fwallet.Address;
	fwallet.Save('t0_wallet.dat');
	fwallet.Load('t0_wallet.dat');
        AssertEquals(previousAddr, fwallet.Address);
END;

END.
