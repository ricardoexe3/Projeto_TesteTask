unit UView.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  UController.ProcessarLista,
  UTypes, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TUViewPrincipal = class(TForm)
    gbPrincipal: TGroupBox;
    btnListaNormal: TButton;
    btnListaTask: TButton;
    mmResult: TMemo;
    dbgFilho: TDBGrid;
    Label1: TLabel;
    dbgPai: TDBGrid;
    Label2: TLabel;
    dsFilho: TDataSource;
    dsPai: TDataSource;
    procedure btnListaNormalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnListaTaskClick(Sender: TObject);
  private
    { Private declarations }
    FControllerProcessarLista: IControllerProcessarLista;
    FDataSets: TArray<TDataSet>;
    procedure LimparMemo;
    procedure AtualizarDataSet;
    procedure ProcessarDados(TipoOperacao: TTipoOperacao);
  public
    { Public declarations }
  end;

var
  UViewPrincipal: TUViewPrincipal;

implementation

{$R *.dfm}

procedure TUViewPrincipal.btnListaNormalClick(Sender: TObject);
begin
  ProcessarDados(tpNormal);
end;

procedure TUViewPrincipal.btnListaTaskClick(Sender: TObject);
begin
  ProcessarDados(tpItask);
end;

procedure TUViewPrincipal.FormCreate(Sender: TObject);
begin
  FControllerProcessarLista := TControllerProcessarLista.New;
  SetLength(FDataSets, 2);
  FDataSets[0] := dsPai.DataSet;
  FDataSets[1] := dsFilho.DataSet;
end;

procedure TUViewPrincipal.LimparMemo;
begin
  mmResult.Lines.Clear;
end;

procedure TUViewPrincipal.ProcessarDados(TipoOperacao: TTipoOperacao);
begin
  dsPai.DataSet := nil;
  dsFilho.DataSet := nil;
  LimparMemo;
  mmResult.Lines.Text :=
    FControllerProcessarLista.SetTipoOperacao(TipoOperacao)
                             .SetDataSet(FDataSets)
                             .ProcessarLista;
  AtualizarDataSet;
end;

procedure TUViewPrincipal.AtualizarDataSet;
begin
  dsPai.DataSet := FDataSets[0];
  dsFilho.DataSet := FDataSets[1];
end;

end.
