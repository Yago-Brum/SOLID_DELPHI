unit uItemInterfaces;

interface

uses
  System.SysUtils;

type
  IOrderItem = interface
  ['{5B0331D4-FDA0-4351-BEBB-D2B45DFD5745}']
    function GetDescription: string;
    function GetPrice: Currency;
    procedure CalculateTotal(Quantity: Integer; out Total: Currency);
  end;

  IPhysicalItem = interface(IOrderItem)
  ['{4BE800CD-1BF8-43F4-9BE3-9D1071639513}']
    function GetWeightKg: Real;
    function GetVolumeCubicMeters: Real;
    function HasDimensions: Boolean;
  end;

  IDigitalItem = interface(IOrderItem)
  ['{181F58F4-0876-4ED1-A7AE-D695E13E4E31}']
    function IsDownloadable: Boolean;
    function GetDownloadLink: string;
  end;

implementation

end.
