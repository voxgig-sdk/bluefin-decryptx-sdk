package core

type BluefinDecryptxError struct {
	IsBluefinDecryptxError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewBluefinDecryptxError(code string, msg string, ctx *Context) *BluefinDecryptxError {
	return &BluefinDecryptxError{
		IsBluefinDecryptxError: true,
		Sdk:              "BluefinDecryptx",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *BluefinDecryptxError) Error() string {
	return e.Msg
}
