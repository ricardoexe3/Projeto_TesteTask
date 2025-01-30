unit UController.ProcessarLista;

interface

uses
  UModel.ProcessarLista,
  UTypes,
  System.Classes,
  DB;

type
  IControllerProcessarLista = interface
    ['{F5B84B51-7161-40F0-8C65-A5C162AC62B1}']
    function ProcessarLista: WideString;
    function SetTipoOperacao(TipoOperacao: TTipoOperacao): IControllerProcessarLista;
    function SetDataSet(var DataSets: TArray<TDataSet>): IControllerProcessarLista;
  end;

type
  TControllerProcessarLista = class(TInterfacedObject, IControllerProcessarLista)
    private
      FTipoOperacao: TTipoOperacao;
      FModelProcessarLista: IModelProcessarLista;
      FDataSet: TArray<TDataSet>;
    public
      function ProcessarLista: WideString;
      function SetTipoOperacao(TipoOperacao: TTipoOperacao): IControllerProcessarLista;
      function SetDataSet(var DataSets: TArray<TDataSet>): IControllerProcessarLista;
      class function New: IControllerProcessarLista;
      constructor Create;
      destructor Destroy; override;
  end;

implementation

{ TControllerProcessarLista }

constructor TControllerProcessarLista.Create;
begin
  FModelProcessarLista := TModelProcessarLista.New;
end;

destructor TControllerProcessarLista.Destroy;
begin
  inherited;
end;

class function TControllerProcessarLista.New: IControllerProcessarLista;
begin
  Result := Self.Create;
end;

function TControllerProcessarLista.ProcessarLista: WideString;
begin
  Result := FModelProcessarLista.SetTipoOperacao(FTipoOperacao)
                                .SetDataSet(FDataSet)
                                .ProcessarLista
end;

function TControllerProcessarLista.SetDataSet(
  var DataSets: TArray<TDataSet>): IControllerProcessarLista;
begin
  Result := Self;
  FDataSet := DataSets;
end;

function TControllerProcessarLista.SetTipoOperacao(
  TipoOperacao: TTipoOperacao): IControllerProcessarLista;
begin
  Result := Self;
  FTipoOperacao := TipoOperacao;
end;

end.
