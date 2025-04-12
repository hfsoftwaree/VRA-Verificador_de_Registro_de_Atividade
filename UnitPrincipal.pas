unit UnitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RxGrdCpt, Registry, EAppProt,
  CJVScrollLabel;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Atividade: TComboBox;
    RxGradientCaption1: TRxGradientCaption;
    Bevel1: TBevel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    EvAppProtect1: TEvAppProtect;
    CJVScrollLabel1: TCJVScrollLabel;
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
{ Declara um tipo registro }
TFicha = record
Nome: string[40];
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
Reg: TRegistry;
Ficha: TFicha;
begin
Reg := TRegistry.Create;
try
{ Define a chave-raiz do registro }
Reg.RootKey := HKEY_CURRENT_USER;
{ Se existir a chave (path)... }
if Reg.KeyExists('Software\vision\1') then
begin
{ Abre a chave (path) }
Reg.OpenKey('Software\vision\1', false);
{ Se existir o valor... }
if Reg.ValueExists('1') then
begin
{ Lê os dados }
Reg.ReadBinaryData('1', Ficha, SizeOf(Ficha));
Edit1.Text := Ficha.Nome;
end else
//ShowMessage('Valor não existe no registro.')
end else
//ShowMessage('Chave (path) não existe no registro.');
finally
Reg.Free;
end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
Reg: TRegistry;
Ficha: TFicha;
begin
  if ATIVIDADE.Text = '' then
	begin
  Application.MessageBox('Atividade Correta deve ser informada!', 'Informação', mb_Ok + mb_IconInformation);
  ATIVIDADE.SetFocus;
  end;

if (ATIVIDADE.Text <> '') then
begin
  if Application.MessageBox('Atenção! Verifique se a Atividade escolhida esta correta, pois o perfeito funcionamento do sistema depende desta informação.', 'Confirmação',
 	mb_YesNo + mb_ICONEXCLAMATION) = idYes then
begin
  { Coloca alguns dados na variável Ficha }
  Ficha.Nome := ATIVIDADE.Text;
  Reg := TRegistry.Create;
  try
  { Define a chave-raiz do registro }
  Reg.RootKey := HKEY_CURRENT_USER;
  { Abre uma chave (path). Se não existir cria e abre. }
  Reg.OpenKey('Software\vision\1', true);
  { Grava os dados (o registro) }
  Reg.WriteBinaryData('1', Ficha,SizeOf(Ficha));
  finally
  Reg.Free;
  self.Close;
  end
  end
  else
  ATIVIDADE.SetFocus;
  end;
end;

end.
