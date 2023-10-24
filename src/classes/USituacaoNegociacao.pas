unit USituacaoNegociacao;

interface
uses
  UId;

type
  TSituacaoNegociacao = class(TId)
  private
    FDestricao: String;
    procedure SetDestricao(const Value: String);

  public
    property Descricao:String read FDestricao write SetDestricao;

  end;


implementation

{ TSituacaoNegociacao }

procedure TSituacaoNegociacao.SetDestricao(const Value: String);
begin
  FDestricao := Value;
end;

end.
