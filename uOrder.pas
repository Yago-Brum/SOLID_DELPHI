unit uOrder;

interface

uses
  System.Classes, System.Generics.Collections, uItemInterfaces, uOrderItems, System.SysUtils;

type
  TStringProc = reference to procedure(const S: string);

  TOrderItemEntry = class
  private
    FItem: IOrderItem;
    FQuantity: Integer;
  public
    constructor Create(AItem: IOrderItem; AQuantity: Integer);
    property Item: IOrderItem read FItem;
    property Quantity: Integer read FQuantity;
  end;

  TOrder = class
  private
    FOrderDate: TDateTime;
    FItems: TList<TOrderItemEntry>;
    FOnLogMessage: TStringProc;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddItem(AItem: IOrderItem; AQuantity: Integer);
    function CalculateTotalOrderValue: Currency;
    procedure ProcessOrder;
    property OnLogMessage: TStringProc read FOnLogMessage write FOnLogMessage;
  end;

implementation

{ TOrderItemEntry }

constructor TOrderItemEntry.Create(AItem: IOrderItem; AQuantity: Integer);
begin
  inherited Create;
  FItem := AItem;
  FQuantity := AQuantity;
end;

{ TOrder }

constructor TOrder.Create;
begin
  inherited Create;
  FOrderDate := Now;
  FItems := TList<TOrderItemEntry>.Create;
  FOnLogMessage := nil;
end;

destructor TOrder.Destroy;
var
  Entry: TOrderItemEntry;
begin
  for Entry in FItems do
  begin
    Entry.Free;
  end;
  FItems.Free;
  inherited Destroy;
end;

procedure TOrder.AddItem(AItem: IOrderItem; AQuantity: Integer);
begin
  FItems.Add(TOrderItemEntry.Create(AItem, AQuantity));
end;

function TOrder.CalculateTotalOrderValue: Currency;
var
  Entry: TOrderItemEntry;
  ItemTotal: Currency;
begin
  Result := 0;
  for Entry in FItems do
  begin
    Entry.Item.CalculateTotal(Entry.Quantity, ItemTotal);
    Result := Result + ItemTotal;
  end;
end;

procedure TOrder.ProcessOrder;
var
  Entry: TOrderItemEntry;
  PhysicalItem: IPhysicalItem;
  DigitalItem: IDigitalItem;
  LogMessage: string;
begin
  if Assigned(FOnLogMessage) then
  begin
    LogMessage := Format('Processing Request %s', [DateTimeToStr(FOrderDate)]);
    FOnLogMessage(LogMessage);

    LogMessage := '--- Items ---';
    FOnLogMessage(LogMessage);
  end;

  for Entry in FItems do
  begin
    if Assigned(FOnLogMessage) then
    begin
      LogMessage := Format('- %d x %s ($ %s)', [Entry.Quantity, Entry.Item.GetDescription, FormatCurr('', Entry.Item.GetPrice)]);
      FOnLogMessage(LogMessage);

      if Supports(Entry.Item, IPhysicalItem, PhysicalItem) then
      begin
        LogMessage := Format('  - Weight: %f kg, Volume: %f m³', [PhysicalItem.GetWeightKg, PhysicalItem.GetVolumeCubicMeters]);
        FOnLogMessage(LogMessage);
      end
      else if Supports(Entry.Item, IDigitalItem, DigitalItem) then
      begin
        LogMessage := Format('  - Download link: %s', [DigitalItem.GetDownloadLink]);
        FOnLogMessage(LogMessage);
      end;
    end;
  end;

  if Assigned(FOnLogMessage) then
  begin
    LogMessage := Format('--- Total Value: $ %s ---', [FormatCurr('', CalculateTotalOrderValue)]);
    FOnLogMessage(LogMessage);
  end;
end;

end.
