unit BustOutputFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.VirtualImage,
  Vcl.BaseImageCollection, Vcl.ImageCollection, ButtonFrame, Vcl.StdCtrls;

type
  TBustFrame = class(TFrame)
    ImageCollection: TImageCollection;
    BackGroundVImage: TVirtualImage;
    BustVImage: TVirtualImage;
    CountLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
