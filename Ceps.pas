unit Ceps;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    btnPesquisar: TButton;
    mmoCeps: TMemo;
    edCep: TEdit;
    imgFundo: TImage;
    Label1: TLabel;
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
  uses RESTRequest4D;
{$R *.dfm}

procedure TForm1.btnPesquisarClick(Sender: TObject);
var
  LResponse: IResponse;
begin
  if edCep.Text = '' then
  begin
    MessageDlg('Campo vazio digite seu cep!', mtWarning,
      [mbOk], 0, mbOk);
      Abort;
  end;
  if StrToIntDef(edCep.Text, 0) in [0..9] then
  begin
    MessageDlg('Digite apenas numeros', mtError,
      [mbOk], 0, mbOk);
      Abort;
  end;
  LResponse := TRequest.New.BaseURL('https://viacep.com.br/ws/' +  edCep.Text + '/json/')
    .Accept('application/json')
    .Get;
  if LResponse.StatusCode = 200 then
    mmoCeps.lines.text	:=  LResponse.Content;
end;
end.
