unit uOrderItems;

interface

uses
  uItemInterfaces, System.SysUtils;

type
  TMetalSparrow = class(TInterfacedObject, IPhysicalItem)
  private
    FDescription: string;
    FPrice: Currency;
    FWeightKg: Real;
    FVolumeCubicMeters: Real;
  public
    constructor Create(ADescription: string; APrice: Currency; AWeightKg: Real; AVolumeCubicMeters: Real);
    function GetDescription: string;
    function GetPrice: Currency;
    procedure CalculateTotal(Quantity: Integer; out Total: Currency);
    function GetWeightKg: Real;
    function GetVolumeCubicMeters: Real;
    function HasDimensions: Boolean;
  end;

  TPenguinEbook = class(TInterfacedObject, IDigitalItem)
  private
    FDescription: string;
    FPrice: Currency;
    FDownloadLink: string;
  public
    constructor Create(ADescription: string; APrice: Currency; ADownloadLink: string);
    function GetDescription: string;
    function GetPrice: Currency;
    procedure CalculateTotal(Quantity: Integer; out Total: Currency);
    function IsDownloadable: Boolean;
    function GetDownloadLink: string;
  end;

implementation

{ TMetalSparrow }

constructor TMetalSparrow.Create(ADescription: string; APrice: Currency; AWeightKg: Real; AVolumeCubicMeters: Real);
begin
  inherited Create;
  FDescription := ADescription;
  FPrice := APrice;
  FWeightKg := AWeightKg;
  FVolumeCubicMeters := AVolumeCubicMeters;
end;

procedure TMetalSparrow.CalculateTotal(Quantity: Integer; out Total: Currency);
begin
  Total := Quantity * FPrice;
end;

function TMetalSparrow.GetDescription: string;
begin
  Result := FDescription;
end;

function TMetalSparrow.GetPrice: Currency;
begin
  Result := FPrice;
end;

function TMetalSparrow.GetVolumeCubicMeters: Real;
begin
  Result := FVolumeCubicMeters;
end;

function TMetalSparrow.GetWeightKg: Real;
begin
  Result := FWeightKg;
end;

function TMetalSparrow.HasDimensions: Boolean;
begin
  Result := (FWeightKg > 0) or (FVolumeCubicMeters > 0);
end;

{ TPenguinEbook }

constructor TPenguinEbook.Create(ADescription: string; APrice: Currency; ADownloadLink: string);
begin
  inherited Create;
  FDescription := ADescription;
  FPrice := APrice;
  FDownloadLink := ADownloadLink;
end;

procedure TPenguinEbook.CalculateTotal(Quantity: Integer; out Total: Currency);
begin
  Total := Quantity * FPrice;
end;

function TPenguinEbook.GetDescription: string;
begin
  Result := FDescription;
end;

function TPenguinEbook.GetPrice: Currency;
begin
  Result := FPrice;
end;

function TPenguinEbook.GetDownloadLink: string;
begin
  Result := FDownloadLink;
end;

function TPenguinEbook.IsDownloadable: Boolean;
begin
  Result := not FDownloadLink.IsEmpty;
end;

end.
