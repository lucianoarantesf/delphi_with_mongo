unit uRouters.Pessoas;

interface

uses System.SysUtils, System.Classes,
  Horse, Jsons, DataSet.Serialize, uControllers.Pessoas;

type
  TRoutersPessoas = class
  private
  public
    class procedure onRegistry;
  end;

implementation

{ TControllerPessoas }
procedure GetPessoa(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  lControllersPessoa: TControllersPessoa;
  lJsonObject: TJsonObject;
  lResponse: String;
begin
  lResponse := '';
  lControllersPessoa := TControllersPessoa.Create(Nil);
  lJsonObject := TJsonObject.Create(Nil);
  try
    try
      lResponse := lControllersPessoa.GetData();
      Res.ContentType('application/json').Send(lResponse).Status(200);
    except
      on E: Exception do
      begin
        lJsonObject.Clear;
        lJsonObject.Put('ERROR', E.Message);
        Res.ContentType('application/json').Send(lJsonObject.Stringify)
          .Status(500);
      end;
    end;
  finally
    lControllersPessoa.DisposeOf;
    lJsonObject.DisposeOf;
  end;
end;

procedure SetPessoa(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  lControllersPessoa: TControllersPessoa;
  lJsonObject: TJsonObject;
  lResponse: String;
  lId, lNome, lSexo, lTrabalho: String;
  lIdade: Integer;
begin
  lId := '';
  lNome := '';
  lSexo := '';
  lTrabalho := '';
  lIdade := 0;
  lControllersPessoa := TControllersPessoa.Create(Nil);
  lJsonObject := TJsonObject.Create(Nil);
  try
    try
      lJsonObject.Parse(Req.Body);

      lId := lJsonObject.Values['cod_pessoa'].AsString;
      lNome := lJsonObject.Values['nome'].AsString;
      lSexo := lJsonObject.Values['sexo'].AsString;
      lTrabalho := lJsonObject.Values['trabalho'].AsString;
      lIdade := lJsonObject.Values['idade'].AsInteger;

      if (lId.IsEmpty) or (lNome.IsEmpty) or (lSexo.IsEmpty) or (lTrabalho.IsEmpty) or
        (lIdade = 0) then raise Exception.Create('Json invalido.'+#13+#10
                                                 +' | Cod_Pessoa: '+lid+#13+#10
                                                 +' | Nome: '+lNome+#13+#10
                                                 +' | Sexo: '+lSexo+#13+#10
                                                 +' | Trabalho: '+lTrabalho+#13+#10
                                                 +' | Idade: '+IntToStr(lIdade));

        lResponse := lControllersPessoa.SetData(lId, lNome, lIdade, lSexo,
          lTrabalho);
      Res.ContentType('application/json').Send(lResponse).Status(200);
    except
      on E: Exception do
      begin
        Res.ContentType('application/json')
          .Send('{ "Erro":"' + E.Message + '"}').Status(500);
      end;
    end;
  finally
    lControllersPessoa.DisposeOf;
    lJsonObject.DisposeOf;
  end;
end;

procedure UpdPessoa(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  lControllersPessoa: TControllersPessoa;
  lJsonObject: TJsonObject;
  lResponse: String;
  lKey,lId, lNome, lSexo, lTrabalho: String;
  lIdade: Integer;
begin
  lKey  := '';
  lId   := '';
  lNome := '';
  lSexo := '';
  lTrabalho := '';
  lIdade := 0;
  lControllersPessoa := TControllersPessoa.Create(Nil);
  lJsonObject := TJsonObject.Create(Nil);
  try
    try
      lJsonObject.Parse(Req.Body);
      lId  := lJsonObject.Values['cod_pessoa'].AsString;
      lNome := lJsonObject.Values['nome'].AsString;
      lSexo := lJsonObject.Values['sexo'].AsString;
      lTrabalho := lJsonObject.Values['trabalho'].AsString;
      lIdade := lJsonObject.Values['idade'].AsInteger;

      if(lId.IsEmpty) or (lNome.IsEmpty) or (lSexo.IsEmpty) or (lTrabalho.IsEmpty) or
        (lIdade = 0) then raise Exception.Create('Json invalido.'+#13+#10
                                                 +' | Cod_Pessoa: '+lid+#13+#10
                                                 +' | Nome: '+lNome+#13+#10
                                                 +' | Sexo: '+lSexo+#13+#10
                                                 +' | Trabalho: '+lTrabalho+#13+#10
                                                 +' | Idade: '+IntToStr(lIdade));

        lResponse := lControllersPessoa.UpdData(lKey,lId, lNome, lIdade, lSexo,lTrabalho);
      Res.ContentType('application/json').Send(lResponse).Status(200);
    except
      on E: Exception do
      begin
        Res.ContentType('application/json')
          .Send('{ "Erro":"' + E.Message + '"}').Status(500);
      end;
    end;
  finally
    lControllersPessoa.DisposeOf;
    lJsonObject.DisposeOf;
  end;
end;

procedure DelPessoa(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
var
  lControllersPessoa: TControllersPessoa;
  lJsonObject: TJsonObject;
  lResponse: String;
  lId: String;
begin
  lId   := '';

  lControllersPessoa := TControllersPessoa.Create(Nil);
  lJsonObject := TJsonObject.Create(Nil);
  try
    try
      lJsonObject.Parse(Req.Body);
      lId  := lJsonObject.Values['cod_pessoa'].AsString;
      if (lId.IsEmpty) then raise Exception.Create('Json invalido.'+#13+#10
                                                 +' | Cod_Pessoa: '+lid);

      lResponse := lControllersPessoa.DelData(lId);
      Res.ContentType('application/json').Send(lResponse).Status(200);
    except
      on E: Exception do
      begin
        Res.ContentType('application/json')
          .Send('{ "Erro":"' + E.Message + '"}').Status(500);
      end;
    end;
  finally
    lControllersPessoa.DisposeOf;
    lJsonObject.DisposeOf;
  end;
end;

class procedure TRoutersPessoas.onRegistry;
begin
  THorse.Get('pessoa', GetPessoa);
  THorse.Post('pessoa/insert', SetPessoa);
  THorse.Put('pessoa/update',UpdPessoa);
  THorse.Delete('pessoa/delete',DelPessoa);
end;

end.
