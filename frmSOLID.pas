unit frmSOLID;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uItemInterfaces, uOrderItems, uOrder, System.Threading;

type
  TForm1 = class(TForm)
    btnTest: TButton;
    Memo1: TMemo;
    procedure btnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnTestClick(Sender: TObject);
var
  MyOrder: TOrder;
  Sparrow: IPhysicalItem;
  Ebook: IDigitalItem;
begin
  Memo1.Clear;
  MyOrder := TOrder.Create;
  try
    MyOrder.OnLogMessage :=
      procedure(const S: string)
      begin
        TThread.Synchronize(nil,
          procedure
          begin
            Memo1.Lines.Add(S);
          end);
      end;

    Sparrow := TMetalSparrow.Create('Metal Sparrow Collector''s Edition', 25.00, 0.15, 0.0001);
    Ebook := TPenguinEbook.Create('E-book: The Secrets of the Penguins', 12.50, 'http://mystore.com/ebooks/pinguins_secret.pdf');


    MyOrder.AddItem(Sparrow, 2);
    MyOrder.AddItem(Ebook, 1);

    MyOrder.ProcessOrder;

  finally
    MyOrder.Free;
  end;
end;

end.

