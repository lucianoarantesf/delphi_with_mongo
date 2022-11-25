unit uProvider.Connection;
interface
uses
  System.SysUtils, System.Classes,
  System.Rtti, System.JSON.Types,
  System.JSON.Readers, System.JSON.BSON,
  System.JSON.Builders,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MongoDB,
  FireDAC.Phys.MongoDBDef,
  FireDAC.Phys.MongoDBWrapper,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  Data.DB,
  jsons;
type
  TProviderConnection = class(TDataModule)
    dbsConnection: TFDConnection;
    FDPhysMongoDriverLink: TFDPhysMongoDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure insertjson(aJson : TJsonObject);
  end;
var
  ProviderConnection: TProviderConnection;
implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TProviderConnection }

{ TProviderConnection }

procedure TProviderConnection.insertjson(aJson: TJsonObject);
begin

end;

end.
