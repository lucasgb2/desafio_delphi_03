unit UFrmCadastroProdutor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TFrmCadastroProdutor = class(TFrmBase)
    EdtNome: TLabeledEdit;
    EdtCPFCNPJ: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroProdutor: TFrmCadastroProdutor;

implementation

{$R *.dfm}

end.
