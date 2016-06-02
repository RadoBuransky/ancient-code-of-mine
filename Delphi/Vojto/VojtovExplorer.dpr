program VojtovExplorer;

uses ShellApi, Windows;

var Path : PChar;

begin
  New( Path );                                  // alokovanie pamate

  GetWindowsDirectory( Path ,                   // ziskanie windows adresara
                        255 );                  // max dlzka cesty

  ShellExecute( 0 ,                             // handle volajuceho okna
                'open' ,                        // 'open', 'print', 'explore'
                PChar( Path+'\explorer.exe' ) , // cesta k suboru
                'http:\\www.gjh.sk\~slovik\' ,  // parametre
                '' ,                            // cesta k default adresaru
                SW_MAXIMIZE );                  // zobrazi a aktivuje max okno

  Dispose( Path );                              // uvolnenie pamate
end.
