unit UFrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  UConsts, System.UITypes;

type
  TFrmBase = class(TForm)
    StatusBar1: TStatusBar;
    pnlControles: TPanel;
    Button1: TButton;
    Button2: TButton;
    pnlCodigo: TPanel;
    EdtId: TLabeledEdit;
    pnlCampos: TPanel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EdtIdExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FFecharJanelaAoSalvar: Boolean;
    FLimparCamposAoSalvar: Boolean;
    procedure SetFecharJanelaAoSalvar(const Value: Boolean);
    procedure SetLimparCamposAoSalvar(const Value: Boolean);
    { Private declarations }
  protected
    procedure SetDataScreen; virtual; abstract;
    procedure SetDataClass; virtual; abstract;
    function BeforeSave: Boolean; virtual; abstract;
    procedure Save; virtual; abstract;
    procedure ClearFields; virtual;
    procedure AdapterFormNewRecord();
    procedure AdapterFormAlterRecord();
    function Load(AId: Integer):Boolean; virtual; abstract;
  public
    property FecharJanelaAoSalvar: Boolean read FFecharJanelaAoSalvar write SetFecharJanelaAoSalvar;
    property LimparCamposAoSalvar: Boolean read FLimparCamposAoSalvar write SetLimparCamposAoSalvar;
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}

procedure TFrmBase.AdapterFormAlterRecord;
begin
  if self.LimparCamposAoSalvar then
    self.ClearFields;
  if Self.FecharJanelaAoSalvar = false then
  begin
    if self.EdtId.Parent.Visible then
    begin
      self.EdtId.Enabled := true;
      self.EdtId.Color := clWindow;
      self.EdtId.SetFocus();
    end;
  end
  else
    close;
end;

procedure TFrmBase.AdapterFormNewRecord;
begin
  self.EdtId.Text := '';
  self.EdtId.Enabled := false;
  self.EdtId.Color := clBtnFace;
end;

procedure TFrmBase.Button1Click(Sender: TObject);
begin
  if MessageDlg(msgConfirmSave, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Self.SetDataClass;
    if Self.BeforeSave() then
    begin
      Self.Save();
      ShowMessage(msgOperacaoSucesso);
      Self.AdapterFormAlterRecord;
    end;
  end;
end;

procedure TFrmBase.Button2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmBase.Button3Click(Sender: TObject);
begin
  self.AdapterFormAlterRecord;
end;

procedure TFrmBase.ClearFields;
var
  i:Integer;
begin
  for I := 0 to Self.ComponentCount -1 do
    if Self.Components[i].ClassType = TEdit then
      TEdit(Self.Components[i]).Clear
    else if Self.Components[i].ClassType = TComboBox then
      TComboBox(Self.Components[i]).Clear
    else if Self.Components[i].ClassType = TLabeledEdit then
      TLabeledEdit(Self.Components[i]).Clear
end;

procedure TFrmBase.EdtIdExit(Sender: TObject);
begin
  if (EdtId.Text <> '') and (Self.Load(StrToInt(EdtId.Text))) then
    Self.SetDataScreen
  else
    self.AdapterFormNewRecord;
end;

procedure TFrmBase.FormCreate(Sender: TObject);
begin
  Self.LimparCamposAoSalvar := true;
  Self.FecharJanelaAoSalvar := False;
end;

procedure TFrmBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TFrmBase.SetFecharJanelaAoSalvar(const Value: Boolean);
begin
  FFecharJanelaAoSalvar := Value;
end;

procedure TFrmBase.SetLimparCamposAoSalvar(const Value: Boolean);
begin
  FLimparCamposAoSalvar := Value;
end;

end.
