unit UModel.ProcessarLista;

interface

uses
  System.classes,
  UTypes,
  System.Threading,
  DBClient,
  DB;

type
  IModelProcessarLista = interface
    ['{019BF253-928A-47D5-94E3-35E5B5B88D80}']
    function ProcessarLista: WideString;
    function SetTipoOperacao(TipoOperacao: TTipoOperacao): IModelProcessarLista;
    function SetDataSet(var DataSets: TArray<TDataSet>): IModelProcessarLista;
  end;

type
  TModelProcessarLista = class(TInterfacedObject, IModelProcessarLista)
    private
      FDataSet: TClientDataSet;
      FDataSet2: TClientDataSet;
      FTipoOperacao: TTipoOperacao;
      FLista: TStringList;
      dInicio: TDateTime;
      FDataSets: TArray<TDataSet>;
      procedure AlimentarPrimeiroLote;
      procedure AlimentarSegundoLote;
      procedure ProcessarListaNormal;
      procedure ProcessarListaTask;
    public
      function ProcessarLista: WideString;
      function SetTipoOperacao(TipoOperacao: TTipoOperacao): IModelProcessarLista;
      function SetDataSet(var DataSets: TArray<TDataSet>): IModelProcessarLista;
      class function New: IModelProcessarLista;
      constructor Create;
      destructor Destroy; override;
  end;

implementation


uses
  System.SysUtils;

const
  sINICIO = 'Início: %s';
  sTERMINO = 'Término: %s';
  sDURACAO = 'Duração: %s';

{ TModelProcessarLista }

procedure TModelProcessarLista.AlimentarPrimeiroLote;
var
  iCont: Integer;
begin
  dInicio := Now;
  FLista.Add(Format(sINICIO, [FormatDateTime('HH:MM:SS:ZZZ', dInicio)]));
  for iCont := 1 to 1000000 do
  begin
    FdataSet.AppendRecord([iCont, 'Registro Pai - ' + intToStr(iCont), iCont + 2]);
  end;
end;

procedure TModelProcessarLista.AlimentarSegundoLote;
var
  iCont: Integer;
begin
  for iCont := 1 to 1000000 do
  begin
    FdataSet2.AppendRecord([iCont, 'Registro Filho - ' + intToStr(iCont), iCont + 2]);
  end;

  FLista.Add(Format(sTERMINO, [FormatDateTime('HH:MM:SS:ZZZ', Now)]));
  FLista.Add(Format(sDURACAO, [FormatDateTime('SS:ZZZ', (Now - dInicio))]));
end;

constructor TModelProcessarLista.Create;
begin
  FLista := TStringList.Create;

  FDataSet := TClientDataSet.Create(nil);
  FDataSet.FieldDefs.Add('ID', ftInteger);
  FDataSet.FieldDefs.Add('Texto', ftString, 30);
  FDataSet.FieldDefs.Add('Seq', ftInteger);

  if not FDataSet.Active then
    FDataSet.CreateDataSet;

  FDataSet2 := TClientDataSet.Create(nil);
  FDataSet2.Close;

  FDataSet2.FieldDefs.Add('ID', ftInteger);
  FDataSet2.FieldDefs.Add('Texto', ftString, 30);
  FDataSet2.FieldDefs.Add('Seq', ftInteger);

  if not FDataSet2.Active then
    FDataSet2.CreateDataSet;
end;

destructor TModelProcessarLista.Destroy;
begin
  FreeAndNil(FLista);
  FreeAndNil(FDataSet);
  FreeAndNil(FDataSet2);
  inherited;
end;

class function TModelProcessarLista.New: IModelProcessarLista;
begin
  Result := Self.Create;
end;

function TModelProcessarLista.ProcessarLista: WideString;
begin
  case TTipoOperacao(FTipoOperacao) of
    tpNormal : ProcessarListaNormal;
    tpITask : ProcessarListaTask;
  end;

  Result := FLista.Text;
  FLista.Clear;
  FDataSets[0] := FDataSet;
  FDataSets[1] := FDataSet2;
end;

procedure TModelProcessarLista.ProcessarListaNormal;
begin
  AlimentarPrimeiroLote;
  AlimentarSegundoLote;
end;

procedure TModelProcessarLista.ProcessarListaTask;
var
  Tarefas: array [0..1] of ITask;
begin
  Tarefas[0] := TTask.Create(AlimentarPrimeiroLote);
  Tarefas[0].Start;

  Tarefas[1] := TTask.Create(AlimentarSegundoLote);
  Tarefas[1].Start;

  TTask.WaitForAll(Tarefas);
end;

function TModelProcessarLista.SetDataSet(
  var DataSets: TArray<TDataSet>): IModelProcessarLista;
begin
  Result := Self;
  FDataSets := DataSets;
end;

function TModelProcessarLista.SetTipoOperacao(
  TipoOperacao: TTipoOperacao): IModelProcessarLista;
begin
  Result := Self;
  FTipoOperacao := TipoOperacao;
end;

end.
