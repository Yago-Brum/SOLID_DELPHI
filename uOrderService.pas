unit uOrderService;

interface

uses
  uOrder,
  uItemInterfaces,
  uOrderItems,
  System.Classes,
  System.SysUtils,
  uLogInterfaces;

type
  TOrderService = class
  private
    //FOnLogMessage: TStringProc;
    FLogListener: ILogListener;
  public
    constructor Create(ALogListener: ILogListener);
    procedure ProcessNewOrder;
  end;

implementation

{ TOrderService }

constructor TOrderService.Create(ALogListener: ILogListener);
begin
  inherited Create;
  FLogListener := ALogListener;
end;

procedure TOrderService.ProcessNewOrder;
var
  Sparrow: IPhysicalItem;
  Ebook: IDigitalItem;
begin
  var MyOrder := TOrder.Create;
  try
    if Assigned(FLogListener) then
      MyOrder.AddLogListener(FLogListener);

    Sparrow := TMetalSparrow.Create('Metal Sparrow Collector''s Edition', 25.00, 0.15, 0.01);
    Ebook := TPenguinEbook.Create('E-book: The Secrets of the Penguins', 12.50, 'http://mystore.com/ebooks/pinguins_secret.pdf');

    MyOrder.AddItem(Sparrow, 2);
    MyOrder.AddItem(Ebook, 1);

    MyOrder.ProcessOrder;
  finally
    MyOrder.Free;
  end;
end;

end.
