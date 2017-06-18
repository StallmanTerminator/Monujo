(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

PROGRAM TestMonujo;

{$mode objfpc}{$H+}

USES
        fpcunit, testregistry, testutils, testreport, TestBase58, TestChecksum;

FUNCTION RunTest(ATest: TTest): Boolean;
VAR
	resultsWriter: TPlainResultsWriter;
	testResult: TTestResult;
BEGIN
	resultsWriter := TPlainResultsWriter.Create;
	testResult := TTestResult.Create;
	result := False;
	TRY
		testResult.AddListener(resultsWriter);
		ATest.Run(testResult);
		ResultsWriter.WriteResult(TestResult);
		result := (TestResult.NumberOfErrors = 0) and (TestResult.NumberOfFailures = 0);
	FINALLY
		testResult.Free;
		resultsWriter.Free;
	END;	
END;

BEGIN
	(* register test *)
        RegisterTest(TTestBase58);
	RegisterTest(TTestChecksum);

	(* run *)
	IF NOT RunTest(GetTestRegistry) THEN
		ExitCode := 1;
END.
