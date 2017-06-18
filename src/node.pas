(*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 *)

UNIT node;

{$mode objfpc}{$H+}

INTERFACE

USES
        fphttpclient,
        fpjson,
        jsonparser,
	math;

TYPE
        TNode = CLASS
        STRICT PRIVATE
                _url: string;
                _currency: string;

                FUNCTION Get(path: string): string;
                FUNCTION GetCurrency: string;
        PUBLIC
                CONSTRUCTOR Create(url: string);

                PROPERTY Currency: string read _currency;

		FUNCTION GetAmountFromAddress(address: string): int64;
        END;

IMPLEMENTATION

        CONSTRUCTOR TNode.Create(url: string);
        BEGIN
                _url := url;
                _currency := GetCurrency;
        END;

        FUNCTION TNode.Get(path: string): string;
        VAR
                HTTPClient: TFPHTTPClient;
        BEGIN
                TRY
                        HTTPClient := TFPHTTPClient.Create(NIL);
                        result := HTTPClient.Get(_url + path);
                FINALLY
                        HTTPClient.Free;
                END;
        END;

        FUNCTION TNode.GetCurrency: string;
        VAR
                data: string;
                json: TJSONData;
        BEGIN
                data := Get('/network/peering');

                json := GetJSON(data);
                result := json.FindPath('currency').AsString;
        END;

	FUNCTION TNode.GetAmountFromAddress(address: string): int64;
	VAR
		data: string;
		json: TJSONData;
		sources: TJSONArray;
		item: TJSONEnum;
		base: int64;
		amount: int64;
	BEGIN
		result := 0;
		data := Get('/tx/sources/' + address);

		json := GetJSON(data);
		sources := TJSONArray(json.FindPath('sources'));
		FOR item IN sources DO
		BEGIN
			base := item.Value.FindPath('base').AsInt64;
			amount := item.Value.FindPath('amount').AsInt64;
			result := result + (amount * 10 ** base);
		END;
	END;
END.
