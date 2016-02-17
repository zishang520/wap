<script language="jscript" runat="server">
/*
@@@@@@@@@@@X5111111111111111sssss111sri;;::,:;is11
@@@@@@@@@@X51111111111111sssrrrrrrssri;;;rsr;:;;is
@@@@@@@@@@555h11ssrrrrrriiiiiii;iiii;;;;s555hs;;;;
@@@@@@@@@@hri;;;;;;;;;;;;::;;::::::::;:ihh55S5sii;
@@@@@@    ,::;;;iiirrsssri:,,,,,.,,,,::s1hh5551irr
@@    .,:;;irs1hh5555hh11si,,,,.. ..,,;rs1hh551irr
@  .,:;is15S399933SSS55hh1si:,,,,...,,;irs11h1rirr
@  :is539GG88899933SSS55hh1r::::::,,,,irss1hh1;ii;
@ .:r98GGGGG888999S5SSS55hhi;;;;i;::,:irss1hhs;ri;
@  :r58GGGGG88935s1S3SSS55s;iiiiri;;:;ss111hhiir;i
@@ .:i1399Sh5hsi;s33333SSs;rr;rssrii;i11hhhhr;ri;i
@@@  ,;r1hhh5hsr5999933S1irr;is1srii;ihh5551irriis
@@@@@  .;15Shs198888995rrsr;;s111r;i;i55555hrrr;i1
@@@@@@  ,rsrsS8GGG889hrssi:ir111si;iii5SSSS5srr;r1
@@@@  .:rir59GGGGG85ss1s;,;iii;;;;iriiS3333Ssrr;i1
@@   ,iirh9GGGGG8S1shhs, .,,:::;ir11rrS399331rri;s
@  .;iis38GGGGG8hshSShsiiiiir1hhhhhh11399999Shsr:r
  ,iir58GGGGG9511SS51sssrr533S555S39999888883hsr,:
 .ii19GGGGG8Srir111hh53399G83398G8S5hh159GGG3hrs,,
 :i18GGGGGGShhSS3988GGGGGGGGGGG9Shshhh1s15S385ri. 
 ,rS8GGGGGGGGGGGGGGGGGG8933935hsrssi;;;iiiir11i,  
 .ih8GGGGGGGGGGGGGGG835h1ss1sri;:.   @@    .,.    
@ :rh98GGGGGGG893SS5hs1h1ri:.    @@@@@@@@@@@@@ @@@
@@ :i1555555hhhsssriii,.   @@@@@@@@@@@@@@@@@@@@@@@
@@  .;irrrrriiii;,    @@@@@@@@@@@@@@@@@@@@@@@@@@@@
*/
ErrorController = IController.create(); //创建控制器，控制器名跟文件名相同
//定义控制器默认方法
ErrorController.extend("Index", function(name){
    F.echo("错误的请求!"); //输出"Error World!"，F.echo为系统方法，详情参考相关节点“F辅助函数库”
});
//定义其他方法
ErrorController.extend("Show", function(name){
    F.echo("I'm MAE!"); 
});
//定义控制器空方法
ErrorController.extend("empty", function(name){
    F.echo("错误：未定义" + name + "方法");
});
</script>