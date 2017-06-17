PROGRAM TestMonujo;

{$mode objfpc}{$H+}

USES
        fpcunit, testregistry, testutils, testreport, TestBase58;

VAR
	resultsWriter: TPlainResultsWriter;
	testResult: TTestResult;
BEGIN
	(* register test *)
        RegisterTest(TTestBase58);

	(* run *)
	resultsWriter := TPlainResultsWriter.Create;
	testResult := TTestResult.Create;
	testResult.AddListener(resultsWriter);

        GetTestRegistry.Run(testResult);

	testResult.Free;
	resultsWriter.Free;
END.
