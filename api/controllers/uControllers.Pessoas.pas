unit uControllers.Pessoas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
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
  FireDAC.Comp.Client, uProvider.Connection, jsons, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Phys.MongoDBDataSet, DataSet.Serialize;

type
  TControllersPessoa = class(TDataModule)
    FDMemTable: TFDMemTable;
    FDMongoDataSet: TFDMongoDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    FProvider: TProviderConnection;
    FConnMongo: TMongoConnection;
    FEnv: TMongoEnv;
    FDoc: TMongoDocument;

    function GetData: String;
    function SetData(aID, aNome: String; aIdade: Integer; aSexo: String;
      aTrabalho: String): String;
    function DelData(aID: String): String;
    function UpdData(aKey, aID: String; aNome: String; aIdade: Integer;
      aSexo: String; aTrabalho: String): String;
  end;

var
  ControllersPessoa: TControllersPessoa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TControllersPessoa.DataModuleCreate(Sender: TObject);
begin
  FProvider := TProviderConnection.Create(Nil);
  FProvider.dbsConnection.Connected := True;
  FConnMongo := TMongoConnection(FProvider.dbsConnection.CliObj);
  FEnv := FConnMongo.Env;

  FDMongoDataSet.Connection := FProvider.dbsConnection;
end;

procedure TControllersPessoa.DataModuleDestroy(Sender: TObject);
begin
  FConnMongo := Nil;
  FEnv := Nil;
  FProvider.DisposeOf;
end;

function TControllersPessoa.DelData(aID: String): String;
var
  lCursor: IMongoCursor;
begin
   FConnMongo['dbsPessoa']['Pessoa'].Remove()
     .Match()
       .Add('cod_pessoa', aID)
     .&End
  .Exec;

    lCursor := FConnMongo['dbsPessoa']['Pessoa'].Find();
    FDMongoDataSet.Close;
    FDMongoDataSet.Cursor := lCursor;
    FDMongoDataSet.Open;
    result := FDMongoDataSet.ToJSONArrayString;
end;

function TControllersPessoa.GetData: String;
var
  lCursor: IMongoCursor;
begin
    lCursor := FConnMongo['dbsPessoa']['Pessoa'].Find();
    FDMongoDataSet.Close;
    FDMongoDataSet.Cursor := lCursor;
    FDMongoDataSet.Open;
    result := FDMongoDataSet.ToJSONArrayString;
end;

function TControllersPessoa.SetData(aID, aNome: String; aIdade: Integer;
  aSexo, aTrabalho: String): String;
var
  lQuery: TMongoQuery;
  lCursor: IMongoCursor;
begin
    FConnMongo['dbsPessoa']['Pessoa']
        .Insert()
          .Values()
           .Add('cod_pessoa', aID)
           .Add('nome', aNome)
           .Add('idade', aIdade)
           .Add('sexo', aSexo)
           .Add('trabalho', aTrabalho)
         .&End
        .Exec;

    lCursor := FConnMongo['dbsPessoa']['Pessoa'].Find();
    FDMongoDataSet.Close;
    FDMongoDataSet.Cursor := lCursor;
    FDMongoDataSet.Open;
    result := FDMongoDataSet.ToJSONArrayString;
end;

function TControllersPessoa.UpdData(aKey, aID, aNome: String; aIdade: Integer;
  aSexo, aTrabalho: String): String;
var
  lCursor: IMongoCursor;
begin
  FConnMongo['dbsPessoa']['Pessoa'].Update()
   .Match  // critérios
     .Add('cod_pessoa', aID)
   .&End
   .Modify// alterações
     .&Set
       .Field('nome', aNome)
       .Field('idade', aIdade)
       .Field('sexo', aSexo)
       .Field('trabalho',aTrabalho)
     .&End
   .&End
  .Exec;

  lCursor := FConnMongo['dbsPessoa']['Pessoa'].Find();
  FDMongoDataSet.Close;
  FDMongoDataSet.Cursor := lCursor;
  FDMongoDataSet.Open;

  result := FDMongoDataSet.ToJSONArrayString;
end;

end.
