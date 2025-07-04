unit uItemInterfaces;

interface

uses
  System.SysUtils;

type
  IOrderItem = interface
    ['{F8C2716E-14A5-421F-B8F5-E93671B30E4A}']
    function GetDescription: string;
    function GetPrice: Currency;
    procedure CalculateTotal(Quantity: Integer; out Total: Currency);
  end;

  IPhysicalItem = interface(IOrderItem)
    ['{7B46805A-D782-4EE9-9B34-4328F4920D52}']
    function GetWeightKg: Real;
    function GetVolumeCubicMeters: Real;
    function HasDimensions: Boolean;
  end;

  IDigitalItem = interface(IOrderItem)
    ['{CE9848E4-7213-4577-A5AD-E8EDCA09FC51}']
    function IsDownloadable: Boolean;
    function GetDownloadLink: string;
  end;

implementation

end.
