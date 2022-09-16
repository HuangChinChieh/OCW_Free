<%@ Page Language="C#" %>

<%

    string Token;
    int RValue;
    Random R = new Random();
    string Lang = "CHT";
    string SID = string.Empty;
    string CT = string.Empty;
    string PCode = string.Empty;
    int GoEwinLogin=0;
    string Version = EWinWeb.Version;
    string LoginFailMessage = "";
    if (CodingControl.FormSubmit()) {
        string LoginGUID = Request["LoginGUID"];
        string LoginPassword = Request["LoginPassword"];
        string LoginAccount = Request["LoginAccount"];
     

        Newtonsoft.Json.Linq.JObject obj_FingerPrint = new Newtonsoft.Json.Linq.JObject();

        string UserIP = CodingControl.GetUserIP();
        EWin.Login.LoginResult LoginAPIResult;
        EWin.Login.LoginAPI LoginAPI = new EWin.Login.LoginAPI();


        RValue = R.Next(100000, 9999999);
        Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());

        LoginAPIResult = LoginAPI.UserLoginByCustomValidate(Token, LoginAccount, LoginPassword, EWinWeb.CompanyCode, UserIP);


        if (LoginAPIResult.ResultState == EWin.Login.enumResultState.OK) {

            string EwinCallBackUrl;
            if ( CodingControl.GetIsHttps())
            {
                EwinCallBackUrl =  "https://" + Request.Url.Authority + "/RefreshParent.aspx?index.aspx";
            }
            else {
                EwinCallBackUrl = "http://" + Request.Url.Authority + "/RefreshParent.aspx?index.aspx";
            }

            Response.SetCookie(new HttpCookie("RecoverToken", LoginAPIResult.RecoverToken) { Expires = System.DateTime.Parse("2038/12/31") });
            Response.SetCookie(new HttpCookie("LoginAccount", LoginAccount) { Expires = System.DateTime.Parse("2038/12/31") });
            Response.SetCookie(new HttpCookie("SID",LoginAPIResult.SID));
            Response.SetCookie(new HttpCookie("CT", LoginAPIResult.CT));
            Response.Redirect("RefreshParent.aspx?index.aspx");

        } else {
            LoginFailMessage = LoginAPIResult.Message;
            //Response.Write("<script>var defalutLoginAccount = '" + LoginAccount +"'; var defaultError = function(){ window.parent.showMessageOK('', mlp.getLanguageKey('登入失敗'),function () { })};</script>");
        }
    }


    if (string.IsNullOrEmpty(Request["SID"]) == false)
    {
        SID = Request["SID"];
    }

    if (string.IsNullOrEmpty(Request["CT"]) == false)
        CT = Request["CT"];

    if (string.IsNullOrEmpty(Request["GoEwinLogin"]) == false) {
        GoEwinLogin = int.Parse(Request["GoEwinLogin"]);
    }

    if (string.IsNullOrEmpty(Request["PCode"]) == false) {
        PCode = Request["PCode"];
    }

    if (GoEwinLogin == 1) {
        string EwinCallBackUrl;

        if (CodingControl.GetIsHttps()) {
            EwinCallBackUrl = "https://" + Request.Url.Authority + "/RefreshParent.aspx?index.aspx";
        } else {
            EwinCallBackUrl = "http://" + Request.Url.Authority + "/RefreshParent.aspx?index.aspx";
        }
        Response.Redirect(EWinWeb.EWinGameUrl + "/Game/Login.aspx?CT=" +   HttpUtility.UrlEncode(CT)   + "&KeepLogin=0"  + "&Action=Custom" + "&Callback=" + HttpUtility.UrlEncode(EwinCallBackUrl) + "&CallbackHash=" + CodingControl.GetMD5(EwinCallBackUrl + EWinWeb.PrivateKey, false));
    }



    EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();

    RValue = R.Next(100000, 9999999);
    Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());

    if (string.IsNullOrEmpty(Request["Lang"]))
    {
        string userLang = CodingControl.GetDefaultLanguage();

        if (userLang.ToUpper() == "zh-TW".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-HK".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-MO".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-CHT".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-CHS".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-SG".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh-CN".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "zh".ToUpper())
        {
            Lang = "CHT";
        }
        else if (userLang.ToUpper() == "en-US".ToUpper())
        {
            Lang = "JPN";
        }
        else if (userLang.ToUpper() == "en-CA".ToUpper())
        {
            Lang = "JPN";
        }
        else if (userLang.ToUpper() == "en-PH".ToUpper())
        {
            Lang = "JPN";
        }
        else if (userLang.ToUpper() == "en".ToUpper())
        {
            Lang = "JPN";
        }
        else if (userLang.ToUpper() == "ko-KR".ToUpper())
        {
            Lang = "JPN";
        }
        else if (userLang.ToUpper() == "ko-KP".ToUpper())
        {
            Lang = "JPN";
        }
        else if (userLang.ToUpper() == "ko".ToUpper())
        {
            Lang = "JPN";
        }
        else if (userLang.ToUpper() == "ja".ToUpper())
        {
            Lang = "JPN";
        }
        else { Lang = "JPN"; }
    }
    else
    {
        Lang = Request["Lang"];

        Lang = Lang.ToUpper();
    }

%>
<!doctype html>
<html id="myHTML" lang="zh-Hant-TW" class="mainHtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>マハラジャ - 一番人気なオンラインカジノアミューズメント</title>
    <meta name='keywords' content="カジノ、スロット、アミューズメント、ゲーム、ギャンブル" />
    <meta name='description' content="知名なオンラインゲームブランドと提携し、信頼価値を追求し、すぐに遊ぶことができる。今すぐサイトを登録して、ゲーム開始！" />
    <meta property="og:site_name" content="マハラジャ" />
    <meta property="og:title" content="一番人気なオンラインカジノアミューズメント - マハラジャ" />
    <meta property="og:Keyword" content="カジノ、スロット、アミューズメント、ゲーム、ギャンブル" />
    <meta property="og:description" content="知名なオンラインゲームブランドと提携し、信頼価値を追求し、すぐに遊ぶことができる。今すぐサイトを登録して、ゲーム開始！" />
    <meta property="og:url" content="https://www.free-maharaja.com/" />
    <!--日文圖片-->
    <meta property="og:image" content="https://www.free-maharaja.com/images/app.png" />
    <meta property="og:type" content="website" />
    <!-- Share image -->
    <!--日文圖片-->
    <link rel="image_src" href="https://www.free-maharaja.com/images/app.png">
    <link rel="shortcut icon" href="images/app.png">
    <link rel="stylesheet" href="css/basic.min.css">
    <link rel="stylesheet" href="css/icons.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/lobby.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;500&display=swap" rel="Prefetch" as="style" onload="this.rel = 'stylesheet'" />

    <link rel="alternate" hreflang="ja" href="https://www.free-maharaja.com/index.aspx?Lang=JPN">
    <link rel="alternate" hreflang="ja-jp" href="https://www.free-maharaja.com/index.aspx?Lang=JPN">
    <link rel="alternate" hreflang="zh-cn" href="https://www.free-maharaja.com/index.aspx?Lang=CHT">
    <link rel="alternate" hreflang="zh-tw" href="https://www.free-maharaja.com/index.aspx?Lang=CHT">
    <link rel="alternate" hreflang="zh" href="https://www.free-maharaja.com/index.aspx?Lang=CHT">
    <link rel="alternate" hreflang="zh-hk" href="https://www.free-maharaja.com/index.aspx?Lang=CHT">
    
</head>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-WRNSR38PQ7"></script>

<script 
  src="https://code.jquery.com/jquery-2.2.4.js"
    integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
    crossorigin="anonymous"></script>
<script type="text/javascript" src="/Scripts/PaymentAPI.js?<%:Version%>"></script>
<script type="text/javascript" src="Scripts/popper.min.js"></script>
<script type="text/javascript" src="/Scripts/LobbyAPI.js?<%:Version%>"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.7.1/swiper-bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bignumber.js/9.0.2/bignumber.min.js"></script>
<script type="text/javascript" src="/Scripts/GameCodeBridge.js?1"></script>
<script type="text/javascript" src="/Scripts/NoSleep.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lozad.js/1.16.0/lozad.min.js"></script>
<script>
    var isSent = false;
    var c = new common();
    var MessageModal;
    var needCheckLogin = false;
    var gameWindow;
    var EWinWebInfo = {
        EWinUrl: "<%=EWinWeb.EWinUrl %>",
        EWinGameUrl: "<%=EWinWeb.EWinGameUrl %>",
        MainCurrencyType: "<%=EWinWeb.MainCurrencyType %>",
        RegisterCurrencyType: "<%=EWinWeb.RegisterCurrencyType %>",
        SID: "<%=SID%>",
        CT: "<%=CT%>",
        UserLogined: false,
        FirstLoaded: false,
        Lang: "<%=Lang%>",
        UserInfo: null,
        DeviceType: getOS(),
        IsOpenGame: false
    };

    var jsonGames = [
        {
            GameName: '36',
            GameBrand: 'CQ9',
            GameLangNameCHT: '夜店大亨',
            GameLangNameJPN: 'パブタイクーン',
            NeedLogin: false
        }, {
            GameName: 'GonzoTH000000001',
            GameBrand: 'EVO',
            GameLangNameCHT: '岡佐的尋寶之旅',
            GameLangNameJPN: 'ゴンゾウ トレイジャー ハント',
            NeedLogin: false
        }, {
            GameName: '254',
            GameBrand: 'BNG',
            GameLangNameCHT: '黑狼-集鴻運',
            GameLangNameJPN: 'ブラックウルフ',
            NeedLogin: false
        }, {
            GameName: 'thelastsundown',
            GameBrand: 'PNG',
            GameLangNameCHT: '終極日落',
            GameLangNameJPN: 'ザ ラースト サンダウン',
            NeedLogin: false
        },
        //{
        //    GameName: '1',
        //    GameBrand: 'BBIN',
        //    GameLangNameCHT: '糖果派對3',
        //    GameLangNameJPN: 'キャンディーパーティ3',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '1187',
        //    GameBrand: 'BBIN',
        //    GameLangNameCHT: '魚蝦蟹開了',
        //    GameLangNameJPN: 'フーヘイハウ',
        //    NeedLogin: true
        //}, {
        //    GameName: '1336',
        //    GameBrand: 'BBIN',
        //    GameLangNameCHT: '酷搜馬戲團',
        //    GameLangNameJPN: 'クソサーカス',
        //    NeedLogin: true
        //}, {
        //    GameName: '76',
        //    GameBrand: 'BBIN',
        //    GameLangNameCHT: '開心消消樂',
        //    GameLangNameJPN: 'アーニポップ',
        //    NeedLogin: true
        //},
        {
            GameName: '202',
            GameBrand: 'BNG',
            GameLangNameCHT: '太陽神殿2 - 集鴻運',
            GameLangNameJPN: 'サン オブ エジプト2',
            NeedLogin: true
        }, {
            GameName: '219',
            GameBrand: 'BNG',
            GameLangNameCHT: '致命毒蘋果-集鴻運',
            GameLangNameJPN: 'マジックアップル',
            NeedLogin: true
        }, {
            GameName: '242',
            GameBrand: 'BNG',
            GameLangNameCHT: '叢林之王-集鴻運',
            GameLangNameJPN: 'タイガージャングル',
            NeedLogin: true
        }, {
            GameName: '256',
            GameBrand: 'BNG',
            GameLangNameCHT: '烈日女神-集鴻運',
            GameLangNameJPN: 'クイーン オブ ザ サン',
            NeedLogin: true
        }, {
            GameName: '187',
            GameBrand: 'BNG',
            GameLangNameCHT: '阿茲特克王朝 - 集鴻運',
            GameLangNameJPN: 'アツテカの太陽',
            NeedLogin: true
        }, {
            GameName: '275',
            GameBrand: 'BNG',
            GameLangNameCHT: '閃耀紅寶石: 集鴻運',
            GameLangNameJPN: 'ルビーヒット',
            NeedLogin: true
        }, {
            GameName: '271',
            GameBrand: 'BNG',
            GameLangNameCHT: '果汁夢工廠',
            GameLangNameJPN: 'ジュースインク',
            NeedLogin: true
        }, {
            GameName: 'DuoFuDuoCaiDiamondEternity',
            GameBrand: 'CG',
            GameLangNameCHT: '1c大福大財-鑽石永恆',
            GameLangNameJPN: 'ダフーダチャイ-ダイアモンドエターニティ',
            NeedLogin: true
        }, {
            GameName: 'GeishaEX',
            GameBrand: 'CG',
            GameLangNameCHT: '新 藝妓',
            GameLangNameJPN: 'ゲイシャ',
            NeedLogin: true
        }, {
            GameName: 'FiveFlowers',
            GameBrand: 'CG',
            GameLangNameCHT: '五花爭豔',
            GameLangNameJPN: '5ディーラーズ',
            NeedLogin: true
        },{
            GameName: 'Baccarat2',
            GameBrand: 'CG',
            GameLangNameCHT: '經典百家樂',
            GameLangNameJPN: 'バカラ2',
            NeedLogin: true
        },
        {
            GameName: 'InternationalSicbo',
            GameBrand: 'CG',
            GameLangNameCHT: '國際骰寶',
            GameLangNameJPN: 'インターナショナルシック・ボー',
            NeedLogin: true
        },
        {
            GameName: 'Wheel',
            GameBrand: 'CG',
            GameLangNameCHT: '經典輪盤',
            GameLangNameJPN: 'ホーイル',
            NeedLogin: true
        },
        {
            GameName: '115',
            GameBrand: 'CQ9',
            GameLangNameCHT: '冰雪女王',
            GameLangNameJPN: 'スノークイーン',
            NeedLogin: true
        },
        {
            GameName: '206',
            GameBrand: 'CQ9',
            GameLangNameCHT: '甜蜜暴擊',
            GameLangNameJPN: 'スイートポップ',
            NeedLogin: true
        },
        {
            GameName: '3',
            GameBrand: 'CQ9',
            GameLangNameCHT: '血之吻',
            GameLangNameJPN: 'ヴァンパイアキス',
            NeedLogin: true
        },
        {
            GameName: '54',
            GameBrand: 'CQ9',
            GameLangNameCHT: '火草泥馬',
            GameLangNameJPN: 'ファニーアルパカ',
            NeedLogin: true
        },
        //{
        //    GameName: 'EWinGaming',
        //    GameBrand: 'EWin',
        //    GameLangNameCHT: '真人百家樂(eWIN)',
        //    GameLangNameJPN: 'EWinゲーミング',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '889',
        //    GameBrand: 'GMW',
        //    GameLangNameCHT: '小紅帽',
        //    GameLangNameJPN: 'レッド',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '917',
        //    GameBrand: 'GMW',
        //    GameLangNameCHT: '聖花',
        //    GameLangNameJPN: 'セイクリドフラワー',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '925',
        //    GameBrand: 'GMW',
        //    GameLangNameCHT: '豪華鑽石升級版',
        //    GameLangNameJPN: 'エクストラダイアモンドデュラクス',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '755',
        //    GameBrand: 'HB',
        //    GameLangNameCHT: '海洋之音',
        //    GameLangNameJPN: 'オーシャンズコール',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '757',
        //    GameBrand: 'HB',
        //    GameLangNameCHT: '超級龍捲風',
        //    GameLangNameJPN: 'スーパーツイスター',
        //    NeedLogin: true
        //},

        {
            GameName: '112',
            GameBrand: 'CQ9',
            GameLangNameCHT: '盜法老墓',
            GameLangNameJPN: 'ピラミッドレイダー',
            NeedLogin: true
        },
        {
            GameName: '140',
            GameBrand: 'CQ9',
            GameLangNameCHT: '火燒連環船2',
            GameLangNameJPN: 'ファイアーレットクリフ2',
            NeedLogin: true
        },
        {
            GameName: '161',
            GameBrand: 'CQ9',
            GameLangNameCHT: '大力神',
            GameLangNameJPN: 'ハーキュリーズ',
            NeedLogin: true
        },
        {
            GameName: '201',
            GameBrand: 'CQ9',
            GameLangNameCHT: '拳霸',
            GameLangNameJPN: 'ムエタイ',
            NeedLogin: true
        },
        {
            GameName: '79',
            GameBrand: 'CQ9',
            GameLangNameCHT: '變色龍',
            GameLangNameJPN: 'カメレオン',
            NeedLogin: true
        },
        //{
        //    GameName: '348',
        //    GameBrand: 'MG',
        //    GameLangNameCHT: '神聖鑽石',
        //    GameLangNameJPN: 'ディバインダイヤモンズ',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '359',
        //    GameBrand: 'MG',
        //    GameLangNameCHT: '亞歷山大女王',
        //    GameLangNameJPN: 'クイーン オブ アレキサンドリア™',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '367',
        //    GameBrand: 'MG',
        //    GameLangNameCHT: '鬼狩',
        //    GameLangNameJPN: 'オニハンター',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '387',
        //    GameBrand: 'MG',
        //    GameLangNameCHT: '奇遇宮殿',
        //    GameLangNameJPN: 'アドベンチャーパレス',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '400',
        //    GameBrand: 'MG',
        //    GameLangNameCHT: '愛麗娜',
        //    GameLangNameJPN: 'アリアナ',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '426',
        //    GameBrand: 'MG',
        //    GameLangNameCHT: '好運經紀人',
        //    GameLangNameJPN: 'ブッキーオブオッズ',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '458',
        //    GameBrand: 'MG',
        //    GameLangNameCHT: '板球明星',
        //    GameLangNameJPN: 'クリケットスター',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '495',
        //    GameBrand: 'MG',
        //    GameLangNameCHT: '美女槍手叢林激戰',
        //    GameLangNameJPN: 'ガールズ ウィズ ガンズ-ジャングル ヒート',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '935',
        //    GameBrand: 'NE',
        //    GameLangNameCHT: '元素：覺醒',
        //    GameLangNameJPN: 'エレメンツ：ザ アウェイクニング',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '965',
        //    GameBrand: 'NE',
        //    GameLangNameCHT: '尋蝶記 2',
        //    GameLangNameJPN: 'バタフライスタックス2',
        //    NeedLogin: true
        //},
        {
            GameName: 'eastereggs',
            GameBrand: 'PNG',
            GameLangNameCHT: '復活節彩蛋',
            GameLangNameJPN: 'イースターエッグ',
            NeedLogin: true
        },
        {
            GameName: 'cloudquest',
            GameBrand: 'PNG',
            GameLangNameCHT: '天際戰神',
            GameLangNameJPN: 'クラウドクエスト',
            NeedLogin: true
        },
        {
            GameName: '261',
            GameBrand: 'BNG',
            GameLangNameCHT: '快樂魚',
            GameLangNameJPN: 'ハッピーフィッシュ',
            NeedLogin: true
        },
        {
            GameName: '191',
            GameBrand: 'BNG',
            GameLangNameCHT: '蠻牛向錢衝: 集鴻運',
            GameLangNameJPN: 'バッファローパワー',
            NeedLogin: true
        },
        {
            GameName: 'vs20rockvegas',
            GameBrand: 'PP',
            GameLangNameCHT: '石頭族賭城',
            GameLangNameJPN: 'ロックベガス',
            NeedLogin: true
        },
        {
            GameName: 'vs25aztecking',
            GameBrand: 'PP',
            GameLangNameCHT: '阿茲特克國王',
            GameLangNameJPN: 'アステカキング',
            NeedLogin: true
        },
        {
            GameName: 'vswayshive',
            GameBrand: 'PP',
            GameLangNameCHT: '星際賞金',
            GameLangNameJPN: 'スターバウンティ',
            NeedLogin: true
        },
        {
            GameName: 'vs25vegas',
            GameBrand: 'PP',
            GameLangNameCHT: '維加斯之夜',
            GameLangNameJPN: 'ベガスナイト',
            NeedLogin: true
        },
        //{
        //    GameName: '1116',
        //    GameBrand: 'RT',
        //    GameLangNameCHT: '波斯寶藏',
        //    GameLangNameJPN: 'ペルシアンフォーチュン',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '1096',
        //    GameBrand: 'RT',
        //    GameLangNameCHT: '幸運魔法師',
        //    GameLangNameJPN: 'ラッキーウィザード',
        //    NeedLogin: true
        //},
        {
            GameName: 'masquerade',
            GameBrand: 'PNG',
            GameLangNameCHT: '皇室化妝舞會',
            GameLangNameJPN: 'ロイヤルマスカレード',
            NeedLogin: true
        },
        {
            GameName: 'roccogallo',
            GameBrand: 'PNG',
            GameLangNameCHT: '羅科加洛',
            GameLangNameJPN: 'ロッコガロ',
            NeedLogin: true
        },
        {
            GameName: 'thepayingpianoclub',
            GameBrand: 'PNG',
            GameLangNameCHT: '鋼琴俱樂部',
            GameLangNameJPN: 'ザ ペーイング ピャーノー クラブ',
            NeedLogin: true
        },
        {
            GameName: 'vs243fortseren',
            GameBrand: 'PP',
            GameLangNameCHT: '希臘眾神',
            GameLangNameJPN: 'グリークゴッズ',
            NeedLogin: true
        },
        {
            GameName: 'vs25goldpig',
            GameBrand: 'PP',
            GameLangNameCHT: '招財福豬',
            GameLangNameJPN: 'ゴールデン ピッグ',
            NeedLogin: true
        },
        {
            GameName: 'vs50northgard',
            GameBrand: 'PP',
            GameLangNameCHT: '北境守護者',
            GameLangNameJPN: 'ノース ガーディアンズ',
            NeedLogin: true
        },
        {
            GameName: 'vs243discolady',
            GameBrand: 'PP',
            GameLangNameCHT: '迪斯科女士',
            GameLangNameJPN: 'ディスコーレーディー',
            NeedLogin: true
        },
        {
            GameName: 'vs243ckemp',
            GameBrand: 'PP',
            GameLangNameCHT: '調皮的皇帝',
            GameLangNameJPN: 'チーキーエンペラー',
            NeedLogin: true
        }
        //,
        //{
        //    GameName: '1087',
        //    GameBrand: 'RT',
        //    GameLangNameCHT: '王者之劍',
        //    GameLangNameJPN: 'レジェンダリーエクスカリバー',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '1146',
        //    GameBrand: 'RT',
        //    GameLangNameCHT: '相撲大賞',
        //    GameLangNameJPN: 'スモウスピン',
        //    NeedLogin: true
        //},
        //{
        //    GameName: '1009',
        //    GameBrand: 'RT',
        //    GameLangNameCHT: '一萬零一夜',
        //    GameLangNameJPN: '10001ナイツ',
        //    NeedLogin: true
        //}
    ];

    function eyeTogger() {
        if ($('#login_Password').attr('type') == 'password') {
            //  <!-- class切換=>icon-eye-off/icon-eye -->
            $('#eyeTogger_i').removeClass('icon-eye-off');
            $('#eyeTogger_i').addClass('icon-eye');
            $('#login_Password').attr('type', 'text');
        } else {
            $('#eyeTogger_i').addClass('icon-eye-off');
            $('#eyeTogger_i').removeClass('icon-eye');
            $('#login_Password').attr('type', 'password');
        }
    }

    function eyeTogger2() {
        if ($('#createAccount_Password').attr('type') == 'password') {
            //  <!-- class切換=>icon-eye-off/icon-eye -->
            $('#eyeTogger2_i').removeClass('icon-eye-off');
            $('#eyeTogger2_i').addClass('icon-eye');
            $('#createAccount_Password').attr('type', 'text');
        } else {
            $('#eyeTogger2_i').addClass('icon-eye-off');
            $('#eyeTogger2_i').removeClass('icon-eye');
            $('#createAccount_Password').attr('type', 'password');
        }
    }

    function switchLang(Lang, isReload) {
        showLoading();
   
        $("#btn_switchlang").children().remove();

        if ($('#footerLangIcon').hasClass('icon-flag-JP')) {
            $('#footerLangIcon').removeClass('icon-flag-JP');
        }

        if ($('#footerLangIcon').hasClass('icon-flag-ZH')) {
            $('#footerLangIcon').removeClass('icon-flag-ZH');
        }
        switch (Lang) {
            case "JPN":
                LangText = "日本語";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-JP"></i>`);
                $('#footerLangIcon').addClass('icon-flag-JP');
                $('#footerLangText').text(LangText);
                setCookie("Lang", "JPN", 365);
                break;
            case "CHT":
                LangText = "繁體中文";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-ZH"></i>`);
                $('#footerLangIcon').addClass('icon-flag-ZH');
                $('#footerLangText').text(LangText);
                setCookie("Lang", "CHT", 365);
                break;
            case "ENG":
                LangText = "日本語";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-JP"></i>`);
                $('#langIcon').addClass('icon-flag-JP');
                $('#footerLangText').text(LangText);
                break;
            case "CHS":
                LangText = "簡體中文";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-ZH"></i>`);
                $('#footerLangIcon').addClass('icon-flag-ZH');
                $('#footerLangText').text(LangText);
                break;
            default:
                LangText = "日本語";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-JP"></i>`);
                $('#footerLangIcon').addClass('icon-flag-JP');
                $('#footerLangText').text(LangText);
                break;
        }

        //document.getElementById("idLangText").innerText = LangText;
        if (isReload) {
            setLanguage(Lang, function () {
                appendGameItem();
                closeLoading();
            });
        }
        $('#ModalLanguage').modal('hide');
        $("#btn_PupLangClose").click();
    }

    function setLanguage(c, cb) {
        EWinWebInfo.Lang = c;
        window.localStorage.setItem("Lang", c);

        mlp.loadLanguage(c, function () {
            if (cb)
                cb();
        });

    }

    function logout(isRefresh) {
        EWinWebInfo.UserInfo = null;
        EWinWebInfo.UserLogined = false;

        for (var i = 0; i < Object.keys(window.sessionStorage).length; i++) {
            var sessionStorageKeys = Object.keys(window.sessionStorage)[i];
            if (sessionStorageKeys != 'OpenGameBeforeLogin') {
                window.sessionStorage.removeItem(sessionStorageKeys);
            }
        }

        delCookie("RecoverToken");
        delCookie("LoginAccount");
        delCookie("CT");
        delCookie("SID");

        if (isRefresh) {
            window.location.href = "Refresh.aspx?index.aspx";
        }
    }

    function getOS() {
        var os = function () {
            var ua = navigator.userAgent,
                isWindowsPhone = /(?:Windows Phone)/.test(ua),
                isSymbian = /(?:SymbianOS)/.test(ua) || isWindowsPhone,
                isAndroid = /(?:Android)/.test(ua),
                isFireFox = /(?:Firefox)/.test(ua),
                isChrome = /(?:Chrome|CriOS)/.test(ua),
                isTablet = /(?:iPad|PlayBook)/.test(ua) || (isAndroid && !/(?:Mobile)/.test(ua)) || (isFireFox && /(?:Tablet)/.test(ua)),
                isPhone = /(?:iPhone)/.test(ua) && !isTablet,
                isPc = !isPhone && !isAndroid && !isSymbian;
            return {
                isTablet: isTablet,
                isPhone: isPhone,
                isAndroid: isAndroid,
                isPc: isPc
            };
        }();

        if (os.isAndroid || os.isPhone) {
            return 1;
        } else if (os.isTablet) {
            return 1;
        } else if (os.isPc) {
            return 0;
        }
    };

    function init() {
        //showLoading();
        mlp = new multiLanguage();
        var cookieLang = getCookie("Lang");
        if (cookieLang != null && cookieLang!="") {
            EWinWebInfo.Lang = cookieLang;
        }
      
        switch (EWinWebInfo.Lang) {
            case "JPN":
                LangText = "日本語";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-JP"></i>`);
                $('#footerLangIcon').addClass('icon-flag-JP');
                $('#footerLangText').text(LangText);

                break;
            case "CHT":
                LangText = "繁體中文";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-ZH"></i>`);
                $('#footerLangIcon').addClass('icon-flag-ZH');
                $('#footerLangText').text(LangText);
                break;
            case "ENG":
                LangText = "日本語";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-JP"></i>`);
                $('#langIcon').addClass('icon-flag-JP');
                $('#footerLangText').text(LangText);
                break;
            case "CHS":
                LangText = "簡體中文";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-ZH"></i>`);
                $('#footerLangIcon').addClass('icon-flag-ZH');
                $('#footerLangText').text(LangText);
                break;
            default:
                LangText = "日本語";
                $("#btn_switchlang").append(`<i class="icon icon-mask icon-flag-JP"></i>`);
                $('#footerLangIcon').addClass('icon-flag-JP');
                $('#footerLangText').text(LangText);
                break;
        }

        mlp.loadLanguage(EWinWebInfo.Lang, function () {

            var loginFailMessage="<%=LoginFailMessage%>"
            if (loginFailMessage != "") {
                
                showMessageOK(mlp.getLanguageKey("登入失敗"), mlp.getLanguageKey(loginFailMessage), function () {
                    window.history.back();
                });
            }

            lobbyClient = new LobbyAPI("/API/LobbyAPI.asmx");

            appendGameFrame();
            appendGameItem();
            closeLoading();
            window.setTimeout(function () {
                lobbyClient.GetCompanySite(Math.uuid(), function (success, o) {
                    if (success) {
                        if (o.Result == 0) {
                            SiteInfo = o;
                            if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                                API_SetLogin(EWinWebInfo.SID, function (logined) {
                                
                                    if (logined == false) {
                                        userRecover();
                                    }
            
                                    EWinWebInfo.FirstLoaded = true;
                                });
                            } else {
                                updateBaseInfo();
                            }

                            //if (cb)
                            //    cb(true);
                        } else {
                            if (o.Message == "InvalidSID") {
                                // login fail
                                EWinWebInfo.UserLogined = false;
                            } else {
                                EWinWebInfo.UserLogined = false;

                                showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                            }

                        }
                    }
                    else {
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"), function () {
                            window.location.href = "index.aspx"
                        });
                    }

                })
            }, 500);

            window.setInterval(function () {
                // refresh SID and Token;
                var guid = Math.uuid();

                if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                    lobbyClient.KeepSID(EWinWebInfo.SID, guid, function (success, o) {
                        if (success == true) {
                            if (o.Result == 0) {
                                needCheckLogin = true;
                            } else {
                                if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                                    needCheckLogin = true;
                                }
                            }
                        }
                    });

                }
            }, 10000);

            window.setInterval(function () {
                if (needCheckLogin == true) {
                    needCheckLogin = false;

                    if ((EWinWebInfo.SID != null) && (EWinWebInfo.SID != "")) {
                        API_SetLogin(EWinWebInfo.SID, function (logined) {
                            if (logined == false) {
                                userRecover();
                            }
                        });
                    } else {
                        updateBaseInfo();
                    }
                }
            }, 1000);

        });

        function API_SetLogin(_SID, cb) {
            var sourceLogined = EWinWebInfo.UserLogined;
            checkUserLogin(_SID, function (logined) {
                updateBaseInfo();

                if (cb) {
                    cb(logined);
                }

                if (sourceLogined == logined) {
                    //notifyWindowEvent("LoginState", logined);
                }
            });
        }

        function checkUserLogin(SID, cb) {
            var guid = Math.uuid();

            lobbyClient.GetUserInfo(SID, guid, function (success, o) {
                if (success) {
                    if (o.Result == 0) {
                      
                        EWinWebInfo.SID = SID;
                        EWinWebInfo.UserLogined = true;
                        EWinWebInfo.UserInfo = o;

                        if (cb)
                            cb(true);
                    } else {
                        if (o.Message == "InvalidSID" || o.Message == "InvalidWebSID") {
                            // login fail
                            EWinWebInfo.UserLogined = false;
                        } else {
                            EWinWebInfo.UserLogined = false;

                            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                        }

                        if (cb)
                            cb(false);
                    }
                } else {
                    // 忽略 timeout 
                }
            });
        }

        function updateBaseInfo() {
            if (EWinWebInfo.UserLogined) {
                $('#idLoginBtn').addClass('is-hide');
                $('#idMenuLogin').removeClass('is-hide');
            } else {
                $('#idMenuLogin').addClass('is-hide');
                $('#idLoginBtn').removeClass('is-hide');
            }
        }

        function userRecover(cb) {

            var recoverToken = getCookie("RecoverToken");
            var LoginAccount = getCookie("LoginAccount");

            if ((recoverToken != null) && (recoverToken != "")) {
                var postData;

                //API_ShowMask(mlp.getLanguageKey("登入復原中"), "full");
                //postData = encodeURI("RecoverToken=" + recoverToken + "&" + "LoginAccount=" + LoginAccount);
                postData = {
                    "RecoverToken": recoverToken,
                    "LoginAccount": LoginAccount
                }
                c.callService("/LoginRecover.aspx", postData, function (success, o) {
                    //API_HideMask();

                    if (success) {
                        var obj = c.getJSON(o);

                        if (obj.ResultCode == 0) {
                            EWinWebInfo.SID = obj.SID;
                            setCookie("RecoverToken", obj.RecoverToken, 365);
                            setCookie("LoginAccount", obj.LoginAccount, 365);
                            setCookie("SID", obj.SID, 365);
                            setCookie("CT", obj.CT, 365);


                            API_RefreshUserInfo(function () {
                                updateBaseInfo();

                                if (cb)
                                    cb(true);
                            });
                        } else {
                            EWinWebInfo.UserLogined = false;
                            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請重新登入") + ":" + mlp.getLanguageKey(obj.Message), function () {
                              logout(true);
                            });

                            if (cb)
                                cb(false);
                        }
                    } else {
                        if (o == "Timeout") {
                            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"));
                        } else {
                            showMessageOK(mlp.getLanguageKey("錯誤"), o);
                        }

                        if (cb)
                            cb(false);
                    }
                });
            }
        }

        $(function () {
            document.onkeydown = function (e) {
                var ev = document.all ? window.event : e;
                if (ev.keyCode == 13) {
                    onBtnSendLogin();
                }
            }
        });
    }

    function CloseGameFrame() {
        $('body').removeClass('modal-open');
        //滿版遊戲介面
        $('#divGameFrame').css('display', 'none');
        //滿版遊戲介面 end
        appendGameFrame();
    }

    function appendGameFrame() {
        $("#divGameFrame").children().remove();
        let vw = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0);
        let vh = Math.max(document.documentElement.clientHeight || 0, window.innerHeight || 0);

        let w = vh * 16 / 9;

        if (w > vw) {
            w = vw - 110;
        } else if (Math.abs(vw - w) < 110) {
            w = vw - 110;
        }

        // class="divGameFrame"
        let tmp = `<div class="divGameFrameWrapper">
            <div class="btn-wrapper">
                <div class="btn btn-game-close" onclick="CloseGameFrame()"><i class="icon icon-mask icon-error"></i></div>
            </div>
            <iframe id="GameIFramePage" style="width:${w}px;height:${vh}px;background-color:#09f" name="mainiframe" sandbox="allow-same-origin allow-scripts allow-popups allow-forms allow-pointer-lock"></iframe>
        </div>`;
        $("#divGameFrame").append(tmp);
    }

    function API_RefreshUserInfo(cb) {
        checkUserLogin(EWinWebInfo.SID, function (logined) {
            updateBaseInfo();

            if (cb != null)
                cb();
        });
    }

    function onBtnSendLogin() {
        var form = document.getElementById("idFormUserLogin");

        if (form.LoginAccount.value.trim() == "") {
            showMessageOK("", mlp.getLanguageKey("請輸入信箱"));
            return false;
   
        } else if (form.LoginPassword.value.trim() == "") {
            showMessageOK("", mlp.getLanguageKey("請輸入密碼"));
            return false;
        } 

        form.reportValidity();

        if (form.checkValidity()) {
            if (navigator.webdriver == false) {
                form.action = "index.aspx";
                form.submit();
            }
        }
    }

    function showLoading() {
        $('.loader-container').show();
        $('.loader-backdrop').hide();
    }

    function closeLoading() {
        $('.loader-backdrop').show();
        $('.loader-container').fadeOut(250, function () {
            $('.iframe-container').show();
        });
    }

    function startCountDown(duration) {
        isSent = true;
        let secondsRemaining = duration;
        let min = 0;
        let sec = 0;

        let countInterval = setInterval(function () {
            let BtnSend = document.getElementById("divSendValidateCodeBtn");
            $('#divSendValidateCodeBtn').attr('disabled', true);
            //min = parseInt(secondsRemaining / 60);
            //sec = parseInt(secondsRemaining % 60);
            BtnSend.innerText = secondsRemaining + "s"

            secondsRemaining = secondsRemaining - 1;
            if (secondsRemaining < 0) {
                clearInterval(countInterval);
                SetBtnSend();
            };

        }, 1000);
    }

    function SetBtnSend() {
        let BtnSend = document.getElementById("divSendValidateCodeBtn");
        $('#divSendValidateCodeBtn').attr('disabled', false);
        BtnSend.innerText = mlp.getLanguageKey("驗證碼");
        isSent = false;
    }

    function onBtnSendValidateCode() {
        if (isSent == false) {
            var mail = $('#createAccount_Mail').val().trim();
            lobbyClient.CheckAccountExist(Math.uuid(), mail, function (success, o) {
                if (success) {
                    if (o.Result != 0) {
                        validateEmail(mail, function (success1) {
                            //test
                            if (success1) {
                                lobbyClient.SetUserMail(Math.uuid(), 0, 0, mail, "", "", "", function (success2, o) {
                                    closeLoading();
                                    if (success2) {
                                        if (o.Result != 0) {
                                            showMessageOK("", mlp.getLanguageKey("發送驗證碼失敗"));
                                        } else {
                                            showMessageOK("", mlp.getLanguageKey("發送驗證碼成功"));
                                            startCountDown(120);

                                        }
                                    }
                                });
                            } else {
                                showMessageOK("", mlp.getLanguageKey("EMail格式有誤"));
                            }
                        });
                    } else {
                        window.parent.showMessageOK("", mlp.getLanguageKey("信箱已存在"));
                    }
                }

            });


       
    

        } else {
            window.parent.showMessageOK("", mlp.getLanguageKey("已發送驗證碼，短時間內請勿重複發送"));
        }
    }

 
    function createAccount() {
        var password = $('#createAccount_Password').val().trim();
        var validateCode = $('#createAccount_ValidateCode').val().trim();
        var mail = $('#createAccount_Mail').val().trim();
        var CurrencyList = EWinWebInfo.RegisterCurrencyType;
        var NickName= $('#createAccount_NickName').val().trim();
        if (mail == "") {
            showMessageOK("", mlp.getLanguageKey("EMail尚未填寫"));
            return false;
        }

        if (validateCode == "") {
            showMessageOK("", mlp.getLanguageKey("驗證碼尚未填寫"));
            return false;
        }

        if (password=="") {
            showMessageOK("", mlp.getLanguageKey("密碼尚未填寫"));
            return false;
        }

        if (NickName=="") {
            showMessageOK("", mlp.getLanguageKey("請輸入暱稱"));
            return false;
        }

      
        if (!$("input[name='chkCreateAccount1']").prop("checked")) {
            showMessageOK("", mlp.getLanguageKey("請勾選所有確認項目"));
            return false;
        }

        if (!$("input[name='chkCreateAccount2']").prop("checked")) {
            showMessageOK("", mlp.getLanguageKey("請勾選所有確認項目"));
            return false;
        }

        var PS = [
            { Name: "EMail", Value: mail },
            { Name: "NickName", Value: NickName },
        ];

        lobbyClient.CheckValidateCode(Math.uuid(), 0, mail, "", "", validateCode, function (success2, o2) {
            if (success2) {
                if (o2.Result != 0) {
                    window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確驗證碼"));
                } else {
                    lobbyClient.CreateAccount(Math.uuid(), mail, password, "", CurrencyList, PS, function (success, o) {
                        if (success) {
                            if (o.Result == 0) {

                                window.parent.showMessageOK(mlp.getLanguageKey("成功"), mlp.getLanguageKey("註冊成功, 請按登入按鈕進行登入"), function () {
                                    $('#userLogin').click();
                                });
                            } else {
                                window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey(o.Message), function () {

                                });
                            }
                        } else {
                            if (o == "Timeout") {
                                window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"), function () {

                                });
                            } else {
                                window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey(o), function () {

                                });
                            }
                        }
                    });
                }
            } else {
                window.parent.showMessageOK("", mlp.getLanguageKey("驗證碼錯誤"));
            }
        });

       
    }

    function openHeaderGame() {
        if (!EWinWebInfo.UserLogined) {

            showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請先登入"), function () {
                showUserLogInModal();
            }, null);
            return false;
        } else {
            openGame('BNG', '242', mlp.getLanguageKey("叢林之王-集鴻運"));
        }
        
    }

    function validateEmail(mail, cb) {
        if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail)) {
            cb(true)
        } else {
            cb(false)
        }
    }

    function showMessageOK(title, message, cbOK) {
        if ($("#alertMsg").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertMsg");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertMsg_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertMsg_OK");
            var divMessageBoxContent = divMessageBox.querySelector(".alertMsg_Text");

            if (MessageModal == null) {
                MessageModal = new bootstrap.Modal(divMessageBox, { backdrop: 'static', keyboard: false });
            }

            if (divMessageBox != null) {
                MessageModal.show();

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.add("is-hide");
                }

                if (divMessageBoxOKButton != null) {

                    divMessageBoxOKButton.onclick = function () {
                        MessageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                divMessageBoxContent.innerHTML = message;
            }
        }
    }

    function showUserLogInModal() {
        $('#userLogin').click();
        $('#ModalUserLogIn').modal('show');
    }

    function showCreateAccountModal() {
        $('#userRegister').click();
        $('#ModalUserLogIn').modal('show');
    }

    function openGame(gameBrand, gameName, gameLangName, needLogin) {

        //先關閉Game彈出視窗(如果存在)
        if (gameWindow) {
            gameWindow.close();
        }

        if (gameBrand.toUpperCase() == "EWin".toUpperCase() || gameBrand.toUpperCase() == "YS".toUpperCase()) {
            gameWindow = window.open("/GameLoading.aspx", "Maharaja Free Game")
          } else {
              if (EWinWebInfo.DeviceType == 1) {
                  gameWindow = window.open("/GameLoading.aspx", "Maharaja Free Game");
                }
          }


        var SID = "";

        if (needLogin) {
            if (!EWinWebInfo.UserLogined) {

                showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("請先登入"), function () {
                    showUserLogInModal();
                }, null);
                return false;
            }
        }

        if (!EWinWebInfo.UserLogined) {
            lobbyClient.GetFreeUserAccount(Math.uuid(), function (success, o) {
                if (success) {
                    if (o.Result == 0) {
                        SID = o.Message;
                        openGameStep2(gameBrand, gameName, gameLangName, SID);
                    } else {
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("試玩遊戲人數已滿,請稍後再試"));
                        gameWindow.close();
                    }
                }
                else {
                    gameWindow.close();
                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"), function () {
                        window.location.href = "index.aspx"
                    });
                }

            })
        } else {
            lobbyClient.DepositUserAccountPoint(Math.uuid(), EWinWebInfo.SID, function (success, o) {
                if (success) {
                    if (o.Result == 0) {
                        SID = EWinWebInfo.SID;
                        openGameStep2(gameBrand, gameName, gameLangName, SID);
                    } else {
                        gameWindow.close();
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"), function () {
                            window.location.href = "index.aspx"
                        });
                    }
                }
                else {
                    gameWindow.close();
                    showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"), function () {
                        window.location.href = "index.aspx"
                    });
                }

            })
        }
    }

    function openGameStep2(gameBrand, gameName, gameLangName,SID) {
        EWinWebInfo.IsOpenGame = true;

        $('.headerGameName').text(gameLangName);

        if (gameBrand.toUpperCase() == "EWin".toUpperCase() || gameBrand.toUpperCase() == "YS".toUpperCase()) {
            gameWindow.location = "/OpenGame.aspx?SID=" + SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + EWinWebInfo.MainCurrencyType + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + "<%=EWinWeb.CasinoWorldUrl%>/CloseGame.aspx";
            } else {
                if (EWinWebInfo.DeviceType == 1) {
                    gameWindow.location = "/OpenGame.aspx?SID=" + SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + EWinWebInfo.MainCurrencyType + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + "<%=EWinWeb.CasinoWorldUrl%>/CloseGame.aspx";

                    //window.location.href = "/kevintest.aspx?SID=" + EWinWebInfo.SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + API_GetCurrency() + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + "<%=EWinWeb.CasinoWorldUrl%>/CloseGame.aspx";

                } else {
                    GameLoadPage("/OpenGame.aspx?SID=" + SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + EWinWebInfo.MainCurrencyType + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + "<%=EWinWeb.CasinoWorldUrl%>/CloseGame.aspx");
                }
            }
    }

    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }

    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    function delCookie(name) {
        var exp = new Date();
        exp.setTime(exp.getTime() - 1);
        cval = getCookie(name);
        if (cval != null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
    }

    function GameLoadPage(url, gameBrand, gameName) {
        $('body').addClass('modal-open');
        var IFramePage = document.getElementById("GameIFramePage");

        if (IFramePage != null) {
            //非滿版遊戲介面
            // $('#headerGameDetailContent').show();
            // $('#GameIFramePage').show();
            //非滿版遊戲介面 end

            //滿版遊戲介面
            $('#divGameFrame').css('display', 'flex');
            //滿版遊戲介面 end

            //var showCloseGameTooltipCount = getCookie("showCloseGameTooltip");
            //if (showCloseGameTooltipCount == '') {
            //    showCloseGameTooltipCount = 0;
            //} else {
            //    showCloseGameTooltipCount = parseInt(showCloseGameTooltipCount);
            //}
            //if (showCloseGameTooltipCount < 3) {
            //    $('#closeGameBtn').tooltip('show');
            //    if (showCloseGameTooltipCount == 0) {
            //        setCookie("showCloseGameTooltip", 1, 365);
            //    } else {
            //        setCookie("showCloseGameTooltip", parseInt(showCloseGameTooltipCount) + 1, 365);
            //    }
            //}

            if (IFramePage.tagName.toUpperCase() == "IFRAME".toUpperCase()) {
                showLoading();

                setTimeout(function () {
                    closeLoading();
                }, 10000);

                IFramePage.src = url;
                IFramePage.onload = function () {
                    closeLoading();
                }
            }
        }
    }

    function appendGameItem() {
        $('#gameList').empty();

        for (var i = 0; i < 30; i++) {
            var data = jsonGames[i];
            var gamefree = "";
            var gamelangName = "";
            if (!data.NeedLogin) {
                gamefree = 'game-free';
            }

            if (EWinWebInfo.Lang == 'JPN') {
                gamelangName = data.GameLangNameJPN;
            } else {
                gamelangName = data.GameLangNameCHT;
            }

            var gameItem = `<div class="game-item ${gamefree}">
                        <div class="game-item-inner">
                            <div class="game-item-link" onclick="openGame('${data.GameBrand}','${data.GameName}','${gamelangName}',${data.NeedLogin})" onmouseover="">
                                <div class="game-item-img">
                                    <div class="img-wrap">
                                        <img class="gameimg lozad"
                                            src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/${data.GameBrand}/PC/${EWinWebInfo.Lang}/${data.GameName}.png">
                                    </div>
                                </div>
                                <div class="game-item-info">
                                    <div class="game-item-info-inner">
                                        <h3 class="game-item-name">${gamelangName}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>`;
            $('#gameList').append(gameItem);
  
        }
        $('#gameList').append(`<div class="wrapper_center" id="wrapper_center">
                        <div class="btn btn-more" onclick="appendGameItem2()">${mlp.getLanguageKey("查看更多")}</div>
                    </div>`);

    }

    function appendGameItem2() {
        $('#wrapper_center').remove();
        for (var i = 30; i < jsonGames.length; i++) {
            var data = jsonGames[i];
            var gamefree = "";
            var gamelangName = "";
            if (!data.NeedLogin) {
                gamefree = 'game-free';
            }

            if (EWinWebInfo.Lang == 'JPN') {
                gamelangName = data.GameLangNameJPN;
            } else {
                gamelangName = data.GameLangNameCHT;
            }

            var gameItem = `<div class="game-item ${gamefree}">
                        <div class="game-item-inner">
                            <div class="game-item-link" onclick="openGame('${data.GameBrand}','${data.GameName}','${gamelangName}',${data.NeedLogin})" onmouseover="">
                                <div class="game-item-img">
                                    <div class="img-wrap">
                                        <img class="gameimg lozad"
                                            src="https://ewin.dev.mts.idv.tw/Files/GamePlatformPic/${data.GameBrand}/PC/${EWinWebInfo.Lang}/${data.GameName}.png">
                                    </div>
                                </div>
                                <div class="game-item-info">
                                    <div class="game-item-info-inner">
                                        <h3 class="game-item-name">${gamelangName}</h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>`;

            $('#gameList').append(gameItem);

        }
    }

    function showPartialHtml(title, pathName, isNeedLang, cbOK) {
        event.stopPropagation();
        event.preventDefault();
        var realPath;
        var divMessageBox = document.getElementById("alertPartialHtml");
        var divMessageBoxOKButton = divMessageBox.querySelector(".alertPartialHtml_OK");
        var divMessageBoxTitle = divMessageBox.querySelector(".alertPartialHtml_Title");
        var divMessageBoxContent = divMessageBox.querySelector(".alertPartialHtml_Content");
        var modal = new bootstrap.Modal(divMessageBox);

        if (isNeedLang) {
            realPath = pathName + "_" + EWinWebInfo.Lang + ".html";
        } else {
            realPath = pathName + ".html";
        }

        if (divMessageBox != null) {
            if (divMessageBoxOKButton != null) {
                divMessageBoxOKButton.onclick = function () {
                    divMessageBoxContent.innerHTML = "";
                    modal.hide();

                    if (cbOK != null)
                        cbOK();
                }
            }

            divMessageBoxTitle.innerHTML = title;

            if (pathName == 'Rules') {
                var rulesHtml = "";
                if (EWinWebInfo.Lang == 'JPN') {
                    rulesHtml = `<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>マハラジャ</title>

    <!-- <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" /> -->
    <link rel="stylesheet" href="css/icons.css" type="text/css" />
    <!-- <link rel="stylesheet" href="css/global.css" type="text/css" /> -->
    <link rel="stylesheet" href="css/manual.css" type="text/css" />
</head>
<body>
    <div class="page-container">
        <!-- Heading-Top -->
        <div id="heading-top"></div>
        <div class="page-content">
            <div class="manual-container">
                <h2 class="language_replace">利用規約</h2>
                <div class="text-wrap">
                    <strong><span>バージョン</span></strong><strong><span>: 1.0</span></strong><br />
                    <strong><span>更新日</span></strong><strong><span>: 29.10.2021</span></strong><br />
                    <br />
                    <br />
                    <span><strong>1. </strong></span><strong><span>一般</span></strong><br />
                    <strong><span>このページは、マハラジャの利用規約（以下利用規約）を構成し、このサイトを利用するすべての登録ユーザーは必ず本利用規約に同意する必要があります。本利用規約およびこの中で明確に言及されている文書は、当事者間の合意および理解し、当社とユーザーの契約関係を規定します。</span></strong><strong> </strong><strong><span>マハラジャ（以下ウェブサイト）を利用する前に、本利用規約をしっかりお読みの上、必ず理解してください。本利用規約にご同意いただけない場合には、ウェブサイトの使用および使用の継続をおやめください。また、プライバシーポリシーに関してもよく理解しておかれることをお勧めします。</span></strong><br />
                    <br />
                    <span><strong>1.1</strong></span><br />
                    <strong><span>本利用規約には、以下のようないくつかの追加用語が含まれています</span></strong><strong><span>:</span></strong><br />
                    <span><strong>-</strong></span><strong><span>プレイすることを選択したゲームのルール（「ルール」）。</span></strong><br />
                    <span><strong>-</strong></span><strong><span>特定のキャンペーンに随時適用される当社のキャンペーン利用規約（「キャンペーン利用規約」）。</span></strong><br />
                    <span><strong>-</strong></span><strong><span>当社がユーザーから収集した、またはユーザーから当社に提供された個人情報の処理に関する条件を定めた当社のプライバシーポリシー。</span></strong><br />
                    <br />
                    <span><strong>1.2</strong></span><br />
                    <strong><span>ユーザーは、随時改正されることがある本利用規約に含まれることを理解し、同意するものとします。さらに、当ウェブサイトまたは当社関連のその他のウェブサイトに登録や使用する場合、ルール、キャンペーン利用規約、プライバシーポリシーに従い、またこれらをすべてを読み、理解したうえで承認するものとみなされます。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>2. </span></strong><strong><span>義務、必須条件および責任</span></strong><br />
                    <br />
                    <strong><span>2.1</span></strong><br />
                    <strong><span>本利用規約に同意しアカウント登録を行うことで、ユーザーは、次のことを表明し、保証するものとします</span></strong><strong>
                        <span>
                            :<br />
                            <br />
                            2.1.1
                        </span>
                    </strong><br />
                    <strong><span>アカウントを個人的に登録する</span></strong><br />
                    <strong><span>ユーザー名およびパスワードを含むユーザーのアカウント情報および、またはウェブサイトを介してユーザーのアカウントにアクセスするすべての方法に関する責任は、ユーザー自身が負うものとします。</span></strong><br />
                    <strong><span>アカウントの安全性が損なわれる疑いがある場合、直ちに当社に連絡し、不正なアクセスを防ぐための適切な措置を講じる必要があります。</span></strong><br />
                    <br />
                    <strong>
                        <span>
                            2.1.2<br />
                            18
                        </span>
                    </strong><strong><span>歳以上であること。</span></strong><strong><span>(</span></strong><strong><span>未満は不可</span></strong><strong><span>)</span></strong><br />
                    <strong><span>未成年者のギャンブルは犯罪です。上記に違反していると思われる合理的な理由があるアカウントは、直ちに閉鎖され、すでに支払われた勝利金額を差し引いたすべての入金額がアカウントユーザーに払い戻されます。</span></strong><br />
                    <br />
                    <strong><span>2.1.3</span></strong><br />
                    <strong><span>当ウェブサイトで開設できるアカウントは一つのみです</span></strong><strong> </strong><strong><span>その理由に関わらず、ユーザーが複数のアカウントの開設、または開設を試みた場合は、当社の裁量で、重複するアカウントでのプレイを無効にすることを含む、ユーザーのいずれか、またはすべてのアカウントを閉鎖する場合があります。</span></strong><br />
                    <br />
                    <strong><span>2.1.4</span></strong><br />
                    <strong><span>ユーザーは他の人に代わってではなく自身のために、楽しむことや娯楽の目的のみで当ウェブサイトを利用するものします。</span></strong><br />
                    <br />
                    <strong><span>2.1.5</span></strong><br />
                    <strong><span>特定の地域では、当ウェブサイトへのアクセスおよび使用する権利が違法とみなされる場合があることを認識するものとします。</span></strong><br />
                    <strong><span>ユーザーの居住地域で、当社のウェブサイトを使用することが許可されているかどうかを確認するのはユーザー自身の責任であり、あらゆる地域での当ウェブサイトへのアクセスは当ウェブサイトが提供するサービスの利用の提案、もしくは勧誘を意味するものではありません。</span></strong><br />
                    <br />
                    <strong><span>2.1.6</span></strong><br />
                    <strong><span>アカウントの登録時および存続期間中に要請される個人情報は、正確なものを提供するものとします。個人情報は、氏名、住所、生年月日、メールアドレス、電話番号、決済情報などを含みますが、これに限定されることはありません。この義務を守り、情報が常に最新のものであることを保証するのはユーザー自身の責任です。情報が変更された場合、および登録フォームで提供した必須情報に変更があった場合は、当社に通知するものとします。</span></strong><br />
                    <br />
                    <strong><span>2.1.7</span></strong><br />
                    <strong><span>当ウェブサイトを使用するほかのプレイヤー、およびマハラジャの従業員であるサポートエージェントに対して、侮辱的もしくは節度に欠いた発言を避け、礼儀正しく接するものとします。チャットの使用は、当社提供サービスに関連する問い合わせのみとさせていただきます。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>3. </span></strong><strong><span>アカウントと認証チェック</span></strong><br />
                    <br />
                    <strong><span>3.1</span></strong><br />
                    <strong><span>当ウェブサイトで賭けをしたり入金をするためには、まずユーザー自身が個人的にアカウント（「アカウント」）を開設する必要があります。当社が提供するゲームを実際にリアルマネーを使ってプレイするためには、当ウェブサイトにて登録しなければなりません。マハラジャは、独自の裁量でアカウントの登録や開設を拒否する権利を有します。</span></strong><br />
                    <br />
                    <strong><span>3.2</span></strong><br />
                    <strong><span>一人のユーザー、</span></strong><strong><span>IP</span></strong><strong><span>アドレス、およびデバイスにつきに認められているのは、一アカウントのみです。複数のアカウントを持つユーザーを特定した場合は、当社は、重複したアカウントを閉鎖し、出金可能な資金を返却する権利を留保します。</span></strong><br />
                    <br />
                    <strong><span>3.3</span></strong><br />
                    <strong><span>アカウント登録過程の一環として、ウェブサイトにログインするためのユーザー名とパスワードを選択する必要があります。ログイン情報を安全に保管することは、ユーザー自身のみの責任です。ユーザーは、ログイン情報を決して誰にも開示してはいけません。当社は、意図的または偶発的、能動的または受動的だったに関わらず、第三者へのログイン情報の開示に起因する、第三者によるアカウントの悪用や誤用に関する責任を一切負いません。ユーザーのログイン情報を使用して行われた活動は、ユーザー自身によって実行されたものとみなされ、そのような活動から生じる責任はすべてユーザーが追うものとします。万が一、第三者がユーザーのログイン情報を認識している場合、当社に通知すること、およびログイン情報を変更することはユーザー自身の責任です。</span></strong><br />
                    <br />
                    <strong><span>3.4</span></strong><br />
                    <strong><span>当社は、いかなる理由に関わらず、いつでもユーザーの身元確認を行い、関連する書類の提出を要請する権利を留保します。これには、以下の事項が含まれますがこれらに限定されません</span></strong><strong><span>: </span></strong><strong><span>身元調査、信用調査、または法律で認められてる個人履歴の調査。こういった調査の基準は各ケースによりますが、氏名、住所、年齢、職業などのユーザーの登録情報の確認、ユーザーの金銭的地位、資金源などのユーザーの金銭的取引の確認、および</span></strong><strong><span>/</span></strong><strong><span>またはゲーム活動などを含みます。</span></strong><br />
                    <strong><span>マハラジャには、そのような調査が行われていることをユーザーに伝える義務は一切ないものとします。これらの調査には、許可を受けた信用照会機関、ユーザーの身元を確認するための身元確認サービス、および</span></strong><strong><span>/</span></strong><strong><span>または不正防止機関などの調査を行う特定の第三者企業の使用が含まれる場合があります。マハラジャは、これらの調査の結果が否定的または不確実な場合、独自の裁量でアカウントを閉鎖し、すべての残高を保留することがあります。すべての個人情報は当社のプライバシーポリシーに従って処理されます。</span></strong><br />
                    <br />
                    <strong><span>3.5</span></strong><br />
                    <strong><span>マハラジャは、法的義務および内部ポリシーに従って、ユーザーのアカウントでの入金または出金の処理を行う際に、適正評価の書類の提出を含む追加の本人確認手続きを行う権利を留保します。適正評価手続きに使われるすべての書類が本物であることを保証するのはユーザーの責任です。偽造書類は、資金の没収およびそのような書類の拒否につながる可能性があります。これらの確認手続きは、合理的な時間枠内で実行されるものとします。なお、疑義を避けるため、これらの確認手続きが実行されるまで、ユーザーのアカウントへの資金の支払いなどを遅らせる場合があります。</span></strong><br />
                    <br />
                    <strong><span>3.6</span></strong><br />
                    <strong><span>マネーロンダリング防止のため、すべての決済取引のチェックが行われます。マハラジャおよびすべての規制または管理機関は、犯罪防止の目的で、すべての取引のモニターまたは調査を要求することができます。マハラジャは、疑わしい取引を関連管轄当局に報告します。また、当社は、当社のゲームに関連する疑わしい行為を認識した場合は、直ちに関連機関に報告するものとします。マハラジャは、該当するマネーロンダリングおよびテロ資金供与防止の法律および規制に従って、アカウントの凍結または閉鎖、およびアカウント残高の保留を行う場合があります。</span></strong><br />
                    <br />
                    <strong><span>3.7</span></strong><br />
                    <strong><span>マハラジャは、当社独自の裁量で、ユーザーとの取引関係を継続することが当社のライセンスおよび一般規制義務、または当社のあらゆるサービスに悪影響を与える可能性があるとみなした場合、一切の説明なしで、個人のアカウントの開設を拒否し、またはいつでもアカウントを凍結または閉鎖する権利を留保します。ただし、マハラジャによりすでに行われている契約上の義務は、法律でマハラジャが使用可能な権利を損なうことなく、順守されるものとします。</span></strong><br />
                    <br />
                    <strong><span>3.8</span></strong><br />
                    <strong><span>ユーザーは、いつでもアカウントにログインし、入金、ボーナスクレジット、勝利金、賭け金などのアカウント履歴を確認することができます。誤りに気付いた場合は、必要に応じて調査および修正ができるよう、直ちにマハラジャに報告する必要があります。</span></strong><br />
                    <br />
                    <strong><span>3.9</span></strong><br />
                    <strong><span>ユーザーのアカウントに、クレジットや勝利金またはその他の資金が誤って入金された場合には、ユーザーは、メールまたはチャットを使って、直ちにマハラジャに報告する必要があります。誤って入金された金額は例外なくマハラジャの所有物であり、ユーザーは該当する金額を直ちにアカウントからマハラジャに返金する必要があります。誤って入金された資金を出金した場合、ユーザーは、直ちに返済する必要のある出金額のマハラジャに対する清算債務者とみなされます。誤って入金されたクレジット、勝利金またはその他の資金を使用して賭けが行われた場合、これらの賭けはすべて無効となります。</span></strong><br />
                    <br />
                    <strong><span>3.10</span></strong><br />
                    <strong><span>アカウント残高の金額にかかわらず、残高に利息は一切支払われません。したがってユーザーは、決してマハラジャを金融機関として扱わないものとします。</span></strong><br />
                    <br />
                    <strong><span>3.11</span></strong><br />
                    <strong><span>ユーザーは、マハラジャが、ユーザーによる不正行為および共謀を固く禁じていることを理解し承認するものとします。不正行為や共謀が行われたと合理的に判断された場合、当社は、そのような行為の結果として行われたと思われる賭けを無効にし、および、またはユーザーのアカウントからすべての資金を没収し、閉鎖する権利を留保します。ほかのプレイヤーが、不正行為や共謀によって不当な利益を得ていると考える合理的な根拠のあるユーザーは、メールまたはチャットでマハラジャに報告する必要があります。</span></strong><br />
                    <br />
                    <strong><span>3.12</span></strong><br />
                    <strong><span>ほかのユーザーアカウントへの資金移動は禁止されています。また、その逆も許可されません。</span></strong><br />
                    <br />
                    <strong><span>3.13</span></strong><br />
                    <strong><span>ユーザーは、当ウェブサイトをハッキングしたり、いかなる方法でも当サイトのコードを変更したりしないことに同意します。また、当サイトを使用するにあたり、ユーザー自身、または第三者にかかわらず、ロボット、自動的、機械的、電子的またはそのほかのデバイスを使用して、当サイトでの決断を自動的に行わないことに同意するものとします。当社は、これらのデバイス、またはプレイヤーに不当な優位性を提供するように作られた外部のリソースが、当ウェブサイトで使用されていると合理的に判断された場合には、そのようなデバイスを使って行われたと思われるプレイを無効にする権利を留保します。当社は、調査の対象となるアカウントを一時閉鎖し、当社の独自の裁量でアカウントを閉鎖する場合があります。当社は、これらのデバイスの使用は詐欺行為と同様であるとみなし、このような場合には、アカウントが閉鎖された時点での残高の払い戻しを行わない権利を留保します。</span></strong><br />
                    <br />
                    <strong><span>3.14</span></strong><br />
                    <strong><span>マハラジャは、外国の政府において重要な地位を占める人物（外国</span></strong><strong><span>PEPs</span></strong><strong><span>）とみなされるユーザーへのサービスの提供は行っておりません。いずれかの段階で外国</span></strong><strong><span>PEPs</span></strong><strong><span>と判断された場合は、ユーザーのアカウントは閉鎖され、すべての入金は返金されます。外国</span></strong><strong><span>PEPs</span></strong><strong><span>としての判断に同意しない場合は、メールまたはチャットでご連絡ください。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>4. </span></strong><strong><span>入金</span></strong><br />
                    <br />
                    <strong><span>4.1</span></strong><br />
                    <strong><span>アカウントへの入金において、ユーザーは、合法的な機関によって発行され、合法的にユーザーの名義である有効なクレジットカード、およびその他の決済手段のみを使用することに同意するものとします。ユーザーの決済手段の名義が、ユーザー自身のものではないと当社が判断した場合、または合理的な根拠がある場合、ユーザーのアカウントを閉鎖し、すべての勝利金を無効にする権利を留保します。マハラジャは、企業向けに発行されたカードの使用を禁止します。</span></strong><br />
                    <br />
                    <strong><span>4.2</span></strong><br />
                    <strong><span>マハラジャでは、さまざまな通貨でのプレイを受け入れています。</span></strong><br />
                    <strong><span>ユーザーはその中からアカウントで使用するデフォルト通貨をひとつ選択しなければなりません。ユーザーが選択した通貨以外の通貨でマハラジャに送金された資金は、その時点での為替レートを使って、ユーザーのデフォルト通貨に変換されます。為替レートの費用はすべてユーザーが負担するものとします。</span></strong><br />
                    <br />
                    <strong><span>4.3</span></strong><br />
                    <strong><span>アカウント開設後、ユーザーは、賭けおよびプレイを開始できる前に最低額以上の入金を行う必要があります。最小および最大入金額は、当ウェブサイトにあるユーザーのアカウントの「入金」ページにて確認できます。ユーザーは、アカウントにある資金のみで賭け、およびプレイすることに同意するものとします。</span></strong><br />
                    <br />
                    <strong><span>4.4</span></strong><br />
                    <strong><span>不正な手段で取得した資金を入金することは違法です。適用される法律に従って、マハラジャは、ユーザーのアカウントへの入金に使用されたクレジットカード</span></strong><strong><span>/</span></strong><strong><span>デビットカードと同じ方法に送金を行います。ひとつ以上のクレジットカード</span></strong><strong><span>/</span></strong><strong><span>デビットカードが登録されている場合は、過去</span></strong><strong><span>6</span></strong><strong><span>か月に最も多く入金に使用された決済口座に送金されます。</span></strong><br />
                    <br />
                    <strong><span>4.5</span></strong><br />
                    <strong><span>クレジットカードまたはデビットカードによる入金を行った場合、当社の合理的な裁量により、該当するカードの下</span></strong><strong><span>4</span></strong><strong><span>桁を除くすべての番号を確認できるカードの表面、および</span></strong><strong><span>CVV</span></strong><strong><span>・</span></strong><strong><span>CVV2</span></strong><strong><span>番号を除く裏面の画像の提出を要請する場合があります。</span></strong><br />
                    <br />
                    <strong><span>4.6</span></strong><br />
                    <strong><span>キャンペーン、ロイヤリティプログラム、またはその他のマーケティングキャンペーンの一環として、ボーナス資金がユーザーのアカウントに加算されることがあります。これらのボーナスはウェブサイト上で賭けに利用する必要があり、そのまま出金する事はできません。</span></strong><br />
                    <strong><span>キャンペーンによっては、各キャンペーンの特定の利用規約に沿って条件を達成すると、これらのボーナスがリアルマネーへ換金される場合があります。詳しくは各キャンペーン利用規約をご参照ください。</span></strong><br />
                    <br />
                    <strong><span>4.7</span></strong><br />
                    <strong><span>アカウントへの入金は、常に金融機関、または決済サービス機関を通じて行われます。入金の手続き、利用規約、利用可能性、手数料および処理時間は、関連する金融機関または決済サービス機関によって異なる場合があります。</span></strong><br />
                    <br />
                    <strong><span>4.8</span></strong><br />
                    <strong><span>クレジットは認められていません。アカウントに十分な資金を維持し、それに応じて賭けを行うことはユーザーの責任です。アカウント残高が不十分な場合のギャンブル取引は成立しません。当社は、ユーザーのアカウントにすべての賭けを補う十分な資金がない場合、不注意で行われたまたは受け入れられた賭けを無効にする権利を留保します。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>5. </span></strong><strong><span>カジノゲーム特有のルール</span></strong><br />
                    <br />
                    <strong><span>5.1</span></strong><br />
                    <strong><span>「無料ゲーム」モードでのゲームプレイから得た勝利金およびアカウント残高は、一切の商業的価値を持たず、現金、クレジット、またいかなる形の利益として償還されることはありません。</span></strong><br />
                    <br />
                    <strong><span>5.2</span></strong><br />
                    <strong><span>当ウェブサイトで提供されているゲームは、ランダム・ナンバー・ジェネレーター（</span></strong><strong><span>RNG)</span></strong><strong><span>を使用し、各ゲームの無作為なゲーム結果、およびプロダクトやゲームが公正であることを保証します。この乱数システムは、認可を受けた独立した第三者機関により監査認証されています。当ウェブサイトの「無料ゲーム」モードと「リアルマネー」モードには、まったく同じ乱数ジェネレーターが使用されています。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>6. </span></strong><strong><span>保証と責任</span></strong><br />
                    <br />
                    <strong><span>6.1</span></strong><br />
                    <strong><span>マハラジャは以下の事項を保証しておりません</span></strong><strong><span>: </span></strong><strong><span>当ウェブサイトが完璧で、エラーなく作動すること、ウェブサイトおよび当サイトで提供しているゲームが中断なくアクセスできること、ウェブサイトとゲームが目的に適合していること。マハラジャは明示的または示唆的にかかわらず、このような保証は一切いたしかねます。</span></strong><br />
                    <br />
                    <strong><span>6.2</span></strong><br />
                    <strong><span>予期できない技術的な問題、または第三者プロバイダーの技術的な問題といったマハラジャの管理外の状況において、マハラジャは、プレイのキャンセルおよび</span></strong><strong><span>/</span></strong><strong><span>または払い戻しを行うことができるものとします。また、ユーザーは、ユーザーのコンピューター機器またはモバイルデバイス、およびインターネッとの接続が、ウェブサイトの性能と操作に影響する可能性があることを認識するものとします。マハラジャは、ユーザーの機器、インターネット接続、または第三者プロバイダーに起因する故障や問題に関して一切責任を負いません。これには、プレイができない、または特定のゲームに関連する情報の表示または受信ができない場合も含まれます。</span></strong><br />
                    <br />
                    <strong><span>6.3</span></strong><br />
                    <strong><span>いかなる理由に関わらず、中断または切断された承認済みのゲームラウンドが生じた場合、すべてのユーザーの取引は正確に記録されています。未完了のゲームラウンドは、通常、ゲームが再開されると復元されるか、またはそれが不可能な場合には、そのゲームラウンドはマハラジャにより削除され、プレイ金額がユーザーのアカウントに払い戻されます。</span></strong><br />
                    <br />
                    <strong><span>6.4</span></strong><br />
                    <strong><span>マハラジャは独自の裁量で、ユーザーに事前通知することなく、当ウェブサイトおよび</span></strong><strong><span>/</span></strong><strong><span>または特定のゲームを一時的に利用不可能にする権利を留保します。当社は、こういった状況の結果としてユーザーに生じた損失について一切の責任を負いません。</span></strong><br />
                    <br />
                    <strong><span>6.5</span></strong><br />
                    <strong><span>マハラジャは、いかなるダウンタイム、サーバーの中断、遅延、またはゲームプレイの技術的もしくは政治的妨害についての一切の責任を負いません。払い戻しは、マハラジャの裁量のみで行われるものとします。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>7. </span></strong><strong><span>免責事項</span></strong><br />
                    <br />
                    <strong><span>7.1</span></strong><br />
                    <strong><span>ユーザーは、当ウェブサイトで提供されるサービスが娯楽目的のみであることを認めるものとします。ユーザーは、当サービスを使用することを要求されてはおらず、ユーザーのみの選択および裁量で当サイトのサービスに参加するものとします。結果として、ユーザーは、ユーザー自身の責任で当ウェブサイトを訪れ、ゲームに参加します。ユーザーは、当ウェブサイトおよびサービスへの関心は、職業上のものではなく個人的なものであり、個人の娯楽の目的のみでアカウントを登録したと断言するものとします。当社が提供するサービスのその他の目的の使用は、固く禁じられています。</span></strong><br />
                    <br />
                    <strong><span>7.2</span></strong><br />
                    <strong><span>前述の規定の一般性を失うことなく、マハラジャおよびその取締役、従業員、パートナー、第三者のゲーム配信会社は、法律または契約上の義務で許可されている範囲で、直接的、間接的、特徴的、結果的、偶発的またはその他のかたちに関わらず、ユーザーの当ウェブサイトの使用またはゲームへの参加に関連して生じた、いかなる損失、費用、経費または損害について責任を負いません。</span></strong><br />
                    <strong><span>なお、ゲームでのエラーまたは誤作動に対するマハラジャの責任は該当のゲームのに限定されます。</span></strong><br />
                    <br />
                    <strong><span>7.3</span></strong><br />
                    <strong><span>当ウェブサイトに表示されているすべての情報は、情報提供のみを目的として提供されており、いかなる性質の専門的なアドバイスを提供することは意図していません。マハラジャおよびその独立したプロバイダーは、情報の誤り、不完全性、不正確さ、遅延、またはその中に含まれる情報に起因した行動について、一切責任を負いません。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>8. </span></strong><strong><span>知的財産</span></strong><br />
                    <br />
                    <strong><span>8.1</span></strong><br />
                    <strong><span>ウェブサイト上のすべての知的財産権</span></strong><strong><span>(IP</span></strong><strong><span>権</span></strong><strong><span>)</span></strong><strong><span>は、マハラジャまたは第三者のソフトウェアプロバイダーに帰属します。当ウェブサイトを利用することによって、当サイトまたはソフトウェアプロバイダーの知的財産権の所有権が、ユーザーに付与されることはありません。知的財産権には、特許、著作権、意匠権、商標、データベース権やこれらいずれかのアプリケーション、また著作者人格権、知識、企業秘密、ドメイン名、</span></strong><strong><span>URL</span></strong><strong><span>、商号、およびその他すべての知的財産権および産業所有権</span></strong><strong><span> (</span></strong><strong><span>およびこれらに関係したライセンス</span></strong><strong><span>) </span></strong><strong><span>などがありますが、登録の有無、登録が可能であるかどうか、特定の国や地域、または世界の他の地域に存続するかどうかにかかわらず、これらに限定されません。</span></strong><br />
                    <br />
                    <strong><span>8.2</span></strong><br />
                    <strong><span>ユーザーは、適用する法律で規定された範囲内で以下のことを行うことはできません</span></strong><strong>
                        <span>
                            :<br />
                            <br />
                            8.2.1
                        </span>
                    </strong><br />
                    <strong><span>ソフトウェアおよび</span></strong><strong><span>/</span></strong><strong><span>またはウェブサイトのコピー、配布、公開、リバースエンジニアリング、逆コンパイル、逆アセンブル、修正または翻訳を行ったり、ソフトウェアおよび</span></strong><strong><span>/</span></strong><strong><span>またはウェブサイトのソースコードから二次的著作物を作成するためにソースコードにアクセスしようとすること。</span></strong><br />
                    <br />
                    <strong><span>8.2.2</span></strong><br />
                    <strong><span>ソフトウェアの販売、譲渡、再許諾、移譲、配布、または第三者への貸与。</span></strong><br />
                    <br />
                    <strong><span>8.2.3</span></strong><br />
                    <strong><span>コンピューターネットワークなどを介して、第三者がソフトウェアを使用できるようにすること。</span></strong><br />
                    <br />
                    <strong><span>8.2.4</span></strong><br />
                    <strong><span>物理的または電子的手段を問わず、ソフトウェアを他国に輸出すること。</span></strong><br />
                    <br />
                    <strong><span>8.2.5</span></strong><br />
                    <strong><span>適用される法律または規制で禁止されている方法でソフトウェアを使用すること。</span></strong><br />
                    <br />
                    <strong>
                        <span>
                            8.2.6<br />
                            IP
                        </span>
                    </strong><strong><span>権に害を及ぼす、またはその可能性がある行為を行うこと、また、マハラジャ、その従業員、取締役、役員、およびコンサルタントのイメージや世評を損なう行為を行うこと。</span></strong><br />
                    <br />
                    <strong><span>8.3</span></strong><br />
                    <strong><span>ユーザーは、ウェブサイトまたはゲームに関連してユーザーが使用する名前や画像（ユーザー名など）が、第三者の知的財産権、プライバシー、またはその他の権利を損害したり、他者に対して不快なものでないことを保証するものとします。ユーザーは、当社のプライバシーポリシーの条件に従い、ウェブサイトまたはゲームに関連するあらゆる目的で、これらの名前および画像を使用する、世界的、取り消し不能、譲渡可能、著作権使用料無料の再許諾可能な許可をマハラジャに付与します。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>9. </span></strong><strong><span>クレーム・仲裁</span></strong><br />
                    <br />
                    <strong><span>9.1</span></strong><br />
                    <strong><span>当ウェブサイトに関するクレームの申し立ては、ウェブサイトの手順に従ってカスタマーサポートチームまでご連絡ください。または、</span></strong><strong><span> service@casino-maharaja.com </span></strong><strong><span>までメールにてご連絡ください。</span></strong><br />
                    <strong><span>特定のゲームに関するクレームは、当該事項が発生してから</span></strong><strong><span>7</span></strong><strong><span>営業日以内に申し立てる必要があります。支払い、アカウントの停止、ボーナスの計算を含むそのほかの事項に関するクレームは、当該事項発生から</span></strong><strong><span>1</span></strong><strong><span>か月以内に申し立てを行う必要があります。</span></strong><br />
                    <br />
                    <strong><span>9.2</span></strong><br />
                    <strong><span>クレームはカスタマーサポートチームにより対処され、サポートエージェントが直ちに解決できない場合にはマハラジャ内でエスカレーションすることとします。ユーザーは、クレームの状況について合理的に通知されるものとします。当社は、可能な限り短い時間で、通常の状況においては</span></strong><strong><span>14</span></strong><strong><span>営業日以内に、クレームを解決するよう常に努めるものとします。</span></strong><br />
                    <br />
                    <br />
                    <strong><span>10. </span></strong><strong><span>一般</span></strong><br />
                    <br />
                    <strong><span>10.1</span></strong><br />
                    <strong><span>本利用規約の条項に違反した場合、または違反したと疑われる合理的な根拠がある場合、当社は、ユーザーのアカウントの開設拒否、停止、または閉鎖、またプレイ金の支払いの差し控え、およびユーザーのアカウントにある残高を損害賠償にあてがう権利を留保します。上記は、状況に応じて適切とみなされる、ユーザーに対する法的措置をとる権利を排除するものではありません。</span></strong><br />
                    <br />
                    <strong><span>10.2</span></strong><br />
                    <strong><span>マハラジャが解散または事実上その業務を終了することになった場合には、ユーザーは事前に通知されるものとします。通知後、マハラジャには、有効解散日または終了日まで、本利用規約から生じる義務を履行する責任があるものとします。</span></strong><br />
                    <br />
                    <strong><span>10.3</span></strong><br />
                    <strong><span>本利用規約は、情報提供および利便性の目的で、多言語にて公開されていますが、日本語版の本利用規約が他の言語版に優先するものとします。</span></strong><br />
                    <br />
                    <strong><span>10.4</span></strong><br />
                    <strong><span>当社は、当社の合理的な管理が及ばない事件、出来事、または原因に起因する当社の本利用規約に基づく義務の履行遅延または不履行について、本利用規約に違反したとされず責任を負わないものとします。</span></strong><br />
                    <br />
                    <strong><span>10.5</span></strong><br />
                    <strong><span>本利用規約のいずれかの規定が、違法または法的強制力がないと判断された場合、そのような規定は本利用規約から分離されます。その他のすべての規定は引き続き有効であり、この分離による影響は一切受けません。</span></strong>

                </div>
            </div>
        </div>
    </div>
</body>`;
                } else {
                    rulesHtml = `<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>マハラジャ</title>
    <!-- <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" /> -->
    <link rel="stylesheet" href="css/icons.css" type="text/css" />
    <!-- <link rel="stylesheet" href="css/global.css" type="text/css" /> -->
    <link rel="stylesheet" href="css/manual.css" type="text/css" />
</head>
<body>
    <div class="page-container">
        <!-- Heading-Top -->
        <div id="heading-top"></div>
        <div class="page-content">
            <div class="manual-container">
                <h2 class="language_replace">利用規約</h2>
                <div class="text-wrap">
                    <p dir="ltr">
                        <strong>
                            版本：1.0<br />
                            更新：12.11.2021<br />
                            <br />
                            <br />
                            1. 一般<br />
                            本頁面構成了 マハラジャ 網頁的使用條款（以下簡稱使用條款），所有使用本網站的註冊用戶必須同意這些使用條款。這些使用條款和此處明確提及的文件構成雙方之間的協議和諒解，並管轄我們與您之間的合同關係。在使用 マハラジャ（以下簡稱本網站）之前，請務必閱讀並理解這些使用條款。如果您不同意這些使用條款，請停止使用並繼續使用本網站。我們還建議您充分了解您的隱私政策。
                        </strong>
                    </p>

                    <p dir="ltr">
                        <strong>
                            1.1<br />
                            這些使用條款包括一些附加條款，例如：<br />
                            --您選擇玩的遊戲規則（&ldquo;規則&rdquo;）<br />
                            --我們不適用於特定活動的活動使用條款（&ldquo;活動使用條款&rdquo;）<br />
                            --我們的隱私政策規定了有關處理我們從您那裡收集的或您提供給我們的個人信息的條款和條件。<br />
                            <br />
                            1.2<br />
                            您理解並同意您受這些使用條款中包含的條款的約束，這些條款可能會不時修訂。此外，通過註冊和使用本網站或我們偶爾擁有的其他網站，您也將遵守規則、活動條款和條件、隱私政策，並閱讀並理解所有這些內容。您將被視為接受這樣做之後。<br />
                            <br />
                            <br />
                            <br />
                            2. 義務、要求和責任<br />
                            <br />
                            2.1<br />
                            同意這些使用條款並註冊帳戶，即表示您聲明並保證：<br />
                            <br />
                            2.1.1<br />
                            個人註冊您的帳戶 您對您的所有帳戶信息，包括您的用戶名和密碼，和/或您通過網站訪問您的帳戶的任何其他方式全權負責。 如果您懷疑您的帳戶已被盜用，您應立即與我們聯繫並採取適當措施防止未經授權訪問您的帳戶和您的帳戶餘額。<br />
                            <br />
                            2.1.2<br />
                            必須年滿 18 歲。（不少於）<br />
                            未成年人賭博是犯罪。有合理理由出現違反上述規定的賬戶將被立即關閉，所有押金將退還給賬戶用戶，減去已支付的中獎金額。<br />
                            <br />
                            2.1.3<br />
                            本網站只能開設一個賬戶<br />
                            無論出於何種原因，如果您開立或嘗試開立多個賬戶，我們會酌情決定您的任何或所有賬戶，包括禁止對重複賬戶下注。可能會被阻止或關閉。<br />
                            <br />
                            2.1.4<br />
                            您自行決定僅出於娛樂和娛樂目的使用本網站，不是代表他人，而是您自己。<br />
                            <br />
                            2.1.5<br />
                            您承認在某些領域您訪問和使用本網站的權利可能被視為非法。<br />
                            您有責任確保您的居住地區允許您使用我們的網站。本網站在所有地區的可用性並不意味著建議或招攬使用本網站提供的服務。<br />
                            <br />
                            2.1.6<br />
                            應真實、完整、準確地提供在賬戶註冊時及賬戶存續期間所要求的個人信息。個人信息包括但不限於姓名、地址、出生日期、電子郵件地址、電話號碼、付款信息等。用戶有責任遵守此義務並確保信息始終是最新的。如果任何信息發生變化或註冊表上提供的所需信息發生變化，我們將通知您。<br />
                            <br />
                            2.1.7<br />
                            我們將以禮貌的方式對待使用本網站的其他玩家和作為 マハラジャ 員工的支持代理，避免侮辱或無節制的言論。聊天的使用僅限於我們的服務和與我們的服務嚴格相關的查詢。在任何情況下都不會接受不遵守此條件的行為。<br />
                            <br />
                            <br />
                            <br />
                            3. 賬戶和認證檢查<br />
                            <br />
                            3.1<br />
                            為了在本網站下注或存款，用戶必須首先親自開立賬戶（&ldquo;賬戶&rdquo;）。為了實際使用真錢玩我們公司提供的遊戲，您必須在本網站註冊。マハラジャ 保留自行決定拒絕註冊或開設賬戶的權利。<br />
                            <br />
                            3.2<br />
                            每個用戶、IP 地址和設備只允許有一個帳戶。如果我們發現一個用戶擁有多個賬戶，我們保留關閉重複賬戶並退還可提取資金的權利。<br />
                            <br />
                            3.3<br />
                            作為帳戶註冊過程的一部分，您需要選擇用戶名和密碼才能登錄網站。確保您的登錄信息安全是您的唯一責任。用戶不得向任何人透露其登錄信息。對於因向第三方披露您的登錄信息而導致的任何第三方濫用或誤用您的帳戶，無論是有意或無意、主動或被動，我們概不負責。使用您的登錄信息進行的活動被認為是由您進行的，您應對此類活動產生的任何責任承擔全部責任。萬一第三方知道您的登錄信息，您有責任通知我們並更改您的登錄信息。<br />
                            <br />
                            3.4<br />
                            我們保留隨時以任何理由驗證您的身份並要求提交相關文件的權利。這包括但不限於：背景調查、信用調查或法律允許的個人歷史調查。這些調查的標準會因情況而異，但會確認用戶的註冊信息，如姓名、地址、年齡、職業、用戶的財務狀況、資金來源等用戶財務交易的確認，和/或遊戲。包括活動等。<br />
                            マハラジャ 沒有義務通知用戶正在進行此類調查。這些調查可能包括使用某些第三方公司進行調查，例如授權的信用推薦機構、驗證用戶身份的身份識別服務和/或欺詐預防機構。如果這些調查的結果是否定的或不確定，マハラジャ 可能會自行決定關閉您的帳戶並扣留所有餘額。所有個人信息將根據我們的隱私政策進行處理。<br />
                            <br />
                            3.5<br />
                            マハラジャ 保留在根據法律義務和內部政策處理您賬戶中的存款或取款時執行額外身份驗證程序的權利，包括提交驗證文件。.. 用戶有責任確保盡職調查過程中使用的所有文件都是真實的。偽造文件可能導致資金被沒收和此類文件被拒絕。這些確認程序應在合理的時間範圍內進行。為避免疑慮，我們可能會延遲向用戶帳戶支付資金，直到執行這些確認程序。<br />
                            <br />
                            3.6<br />
                            檢查所有付款交易以防止洗錢。マハラジャ 和所有監管或管理機構可能會出於預防犯罪的目的要求對所有交易進行監控或調查。マハラジャ 向相關主管部門報告可疑交易。此外，我們將立即向相關組織報告與我們的遊戲有關的任何可疑活動。マハラジャ 可能會根據適用的反洗錢和恐怖主義融資法律法規凍結或關閉您的賬戶並保留您的賬戶餘額。<br />
                            <br />
                            3.7<br />
                            網上賭場的世界，在我們的判斷，在所有的情況下，繼續與貴公司建立業務關係，願我們的許可證和一般監管義務，或我們的任何服務產生負面影響。我們保留拒絕開立個人帳戶或凍結權或隨時關閉帳戶而無需解釋。但是，在線賭場世界已經作出的合同義務應得到遵守，但不影響法律使用在線賭場世界的權利。<br />
                            <br />
                            3.8<br />
                            用戶可以隨時登錄他們的賬戶，查看他們的賬戶歷史，如存款、紅利、獎金和賭注。如果您發現錯誤，您應該立即將其報告給 マハラジャ，以便您可以根據需要進行調查和糾正。<br />
                            <br />
                            3.9 如果積分、獎金或其他資金意外存入您的賬戶，您必須立即通過電子郵件或聊天向 マハラジャ 報告。錯誤存入的金額無一例外是 マハラジャ 的財產，用戶必須立即將適用金額從其帳戶退還給 マハラジャ。如果您提取意外存入的資金，您將被視為在線賭場世界的清算債務人，需要立即償還提取金額。如果您使用意外存入的積分、獎金或其他資金進行投注，所有這些投注都將無效。<br />
                            <br />
                            3.10<br />
                            無論您的賬戶餘額有多少，您的餘額都不會支付利息。因此，用戶絕不能將 マハラジャ 視為金融機構。<br />
                            <br />
                            3.11<br />
                            用戶理解並承認，在線賭場世界嚴禁用戶作弊和串謀。如果合理確定發生了欺詐或勾結，我們將取消因此類行為而進行的任何投注和/或沒收用戶賬戶中的所有資金。我們保留關閉的權利。有合理依據的用戶如果認為其他玩家通過欺騙或陰謀不公平地獲利，應通過電子郵件或聊天向 マハラジャ 報告。<br />
                            <br />
                            3.12<br />
                            禁止向其他用戶賬戶轉賬。此外，不允許反向。<br />
                            <br />
                            3.13<br />
                            您同意不會以任何方式入侵我們的網站或修改我們的代碼。我們還使用機器人、自動、機械、電子或其他設備在我們的網站上自動做出決定，無論是通過您或第三方在使用本網站時的試驗或行動。您同意不這樣做。如果我們合理確定這些設備或旨在為玩家提供不公平優勢的外部資源正在本網站上使用，我們保留取消任何可能使用的投注的權利。我們可能會暫時關閉接受調查的帳戶，並自行決定關閉該帳戶。我們認為使用這些設備是欺詐行為，並保留在這種情況下在您的帳戶關閉時不退還您的餘額的權利。<br />
                            <br />
                            3.14<br />
                            マハラジャ 不向在外國政府中被視為重要人物（外國 PEP）的用戶提供服務。如果在任何階段被確定為外國 PEP，用戶的賬戶將被關閉，所有押金將被退還。如果您不同意我們作為外國 PEP 的決定，請通過電子郵件或聊天與我們聯繫。<br />
                            <br />
                            <br />
                            <br />
                            4. 入金<br />
                            <br />
                            4.1 在向您的賬戶入金時，您同意僅使用由合法機構發行的、以您的名義合法的有效信用卡和其他支付方式。.. 如果我們確定您的付款方式名稱不是您的或有合理理由，我們保留關閉您的帳戶並使所有獎金無效的權利。.. マハラジャ 禁止使用發給企業的卡。<br />
                            <br />
                            4.2<br />
                            マハラジャ 接受各種貨幣的投注。<br />
                            用戶必須選擇一種默認貨幣以在其帳戶中使用。以用戶選擇的貨幣以外的貨幣轉移到 マハラジャ 的資金將使用當前匯率轉換為用戶的默認貨幣。所有匯率費用由用戶承擔。<br />
                            <br />
                            4.3<br />
                            開戶後，用戶必須進行最低存款額，方可開始投注和玩遊戲。最低和最高存款可以在本網站您賬戶的&ldquo;存款&rdquo;頁面上找到。您同意僅使用您帳戶中的資金下注和玩遊戲。<br />
                            <br />
                            4.4<br />
                            存入以欺詐手段獲得的資金屬於違法行為。根據適用法律，マハラジャ 將以與用於將資金存入您賬戶的信用卡/借記卡相同的方式轉賬。如果您註冊了不止一張信用卡/借記卡，它們將被發送到過去 6 個月內用於存款最多的支付賬戶。<br />
                            <br />
                            4.5<br />
                            如果您使用信用卡或借記卡進行存款，在我們的合理判斷下，您可以看到除卡的最後 4 位數字外的所有數字，以及除 CVV / CVV2 號碼外的背面圖像。我們可能會要求你提交。<br />
                            <br />
                            4.6<br />
                            獎勵資金可能會作為活動、忠誠度計劃或其他營銷活動的一部分添加到您的帳戶中。這些獎金必須用於在網站上投注，不能按原樣提取。<br />
                            根據活動的不同，如果根據每個活動的特定條款和條件滿足條件，則這些獎金可以兌換為真錢。詳情請參閱各活動的條款及細則。<br />
                            <br />
                            4.7<br />
                            向您的賬戶存款始終是通過金融機構或支付服務機構進行的。存款程序、使用條款、可用性、費用和處理時間可能因相關金融機構或支付服務機構而異。<br />
                            <br />
                            4.8<br />
                            不允許使用積分。用戶有責任在賬戶中保持足夠的資金並相應地下注。如果賬戶餘額不足，賭博交易將無法完成。如果您的賬戶沒有足夠的資金來支付所有投注，我們保留取消無意或接受的投注的權利。<br />
                            <br />
                            <br />
                            <br />
                            5. 賭場遊戲特定規則<br />
                            <br />
                            5.1<br />
                            在&ldquo;免費遊戲&rdquo;模式下玩遊戲賺取的獎金和賬戶餘額沒有商業價值，必須兌換為現金、積分或任何形式的利潤。沒有。<br />
                            <br />
                            5.2<br />
                            本網站提供的遊戲使用隨機數生成器（RNG），以確保每個遊戲的結果都是隨機的，產品和遊戲的公平性。該隨機數系統是由一個獨立的，許可的第三方審核和認證。本網站的&ldquo;免費遊戲&rdquo;模式和&ldquo;真錢&rdquo;模式使用完全相同的隨機數生成器。<br />
                            <br />
                            <br />
                            <br />
                            6. 保證與責任<br />
                            <br />
                            6.1<br />
                            マハラジャ 不保證以下內容： 本網站完美無誤，您可以不間斷地訪問本網站和本網站提供的遊戲，並且遊戲符合目的。マハラジャ 不作任何此類保證，無論是明示的還是暗示性的。<br />
                            <br />
                            6.2<br />
                            在マハラジャ 無法控制的情況下，例如不可預見的技術問題或第三方提供商的技術問題，マハラジャ 可能會取消和/或退還投注。您還承認，您與計算機或移動設備以及互聯網的連接可能會影響您網站的性能和運行。マハラジャ 不對由您的設備、互聯網連接或第三方提供商造成的任何故障或問題負責。這包括您無法下注或無法查看或接收與特定遊戲相關的信息。<br />
                            <br />
                            6.3<br />
                            如果批准的遊戲回合因任何原因中斷或斷開連接，所有用戶交易都將被準確記錄。未完成的遊戲回合通常會在遊戲恢復時恢復，如果無法恢復，在線賭場世界將刪除該遊戲回合併將本金退還給用戶的帳戶。增加。<br />
                            <br />
                            6.4<br />
                            マハラジャ 保留自行決定暫時禁用本網站和/或某些遊戲的權利，恕不另行通知用戶。用戶因此而遭受的任何損失，我們概不負責。<br />
                            <br />
                            6.5<br />
                            マハラジャ 不對遊戲的任何停機時間、服務器中斷、延遲或技術或政治干擾負責。退款僅由 マハラジャ 自行決定。<br />
                            <br />
                            <br />
                            <br />
                            7. 免責聲明<br />
                            <br />
                            7.1<br />
                            用戶承認本網站提供的服務僅用於娛樂目的。用戶無需使用服務，應自行決定是否參與本網站的服務。因此，您有責任訪問我們的網站並參與遊戲。您聲明您對本網站和服務的興趣是個人的而非專業的，並且您註冊您的帳戶僅用於個人娛樂目的。嚴禁將我們提供的服務用於任何其他目的。<br />
                            <br />
                            7.2<br />
                            在不失上述規定的一般性的情況下，マハラジャ 及其董事、員工、合作夥伴和第三方遊戲經銷商，在法律或合同義務允許的範圍內，直接，我們對任何損失、費用、費用或損害承擔責任因您使用我們的網站或您參與遊戲而產生的，無論是間接的、特徵性的、後果性的、意外的或其他的。<br />
                            請注意，マハラジャ 對遊戲中的錯誤或故障的責任僅限於遊戲的交換。<br />
                            <br />
                            7.3<br />
                            本網站上顯示的所有信息僅供參考，無意提供任何性質的專業建議。マハラジャ 及其獨立提供商不對任何錯誤、不完整、不准確、延遲或根據其中包含的信息採取的行動負責。<br />
                            <br />
                            <br />
                            <br />
                            8. 知識產權<br />
                            <br />
                            8.1<br />
                            網站上的所有知識產權（IP rights）均屬於 マハラジャ 或第三方軟件提供商。通過使用本網站，本網站或軟件提供商的知識產權的所有權並不授予用戶。知識產權包括專利、版權、工業權、商標、數據庫權利和任何這些應用程序，以及精神權利、專有技術、商業秘密、域名、URL、商號和所有其他知識產權。這些包括產權和商業秘密（及相關許可），無論是否已註冊，是否可以註冊，是否在特定國家或地區或世界其他地區生存，不限於這些。<br />
                            <br />
                            8.2<br />
                            用戶，我們不能在法律規定的適用範圍內進行以下行為：<br />
                            <br />
                            8.2.1<br />
                            軟件和/或網站的副本、分發、發布、反向工程、反編譯、反彙編、修改或翻譯和訪問、軟件和/或嘗試訪問源代碼以從網站的源代碼創建衍生作品。<br />
                            <br />
                            8.2.2<br />
                            軟件銷售、轉讓、再許可、轉讓、分發或出租。<br />
                            <br />
                            8.2.3<br />
                            軟件可用給第三方，如通過計算機網絡。<br />
                            <br />
                            8.2.4<br />
                            通過物理或電子方式導出軟件到其他國家。<br />
                            <br />
                            8.2.5<br />
                            適用的法律或使用法規所禁止的方式將軟件。<br />
                            <br />
                            8.2.6<br />
                            損害知識產權，或進行有行為的可能性，在線賭場世界，其員工，董事，執行損害形象和聲譽的官員和顧問的行為。<br />
                            <br />
                            8.3<br />
                            用戶，網站或使用的名稱和圖像用戶與遊戲相關的（如用戶名）不損害第三方的知識產權、隱私或其他權利或冒犯他人。應予以保證。您可以根據我們的隱私政策的條款，將這些名稱和圖像用於與您的網站或遊戲相關的任何目的，在全球範圍內，不可撤銷、可轉讓且無版權。授予 マハラジャ 許可。<br />
                            <br />
                            <br />
                            <br />
                            9. 索賠和仲裁<br />
                            <br />
                            9.1 如果您對本網站有任何投訴，請按照網站上的說明聯繫客戶支持團隊。或者，請發送電子郵件至 service@casino-maharaja.com。<br />
                            有關特定遊戲的索賠必須在事件發生後的 7 日內提出。其他事項的索賠，包括付款、帳戶暫停和獎金計算，必須在此類事項發生後的一個月內提出。<br />
                            <br />
                            9.2<br />
                            如果支持代理無法立即解決索賠，則索賠將由客戶支持團隊處理並在 マハラジャ 內升級。應合理地通知用戶索賠的狀態。在正常情況下，我們將始終努力在最短的時間內和 14 個工作日內解決您的索賠。<br />
                            <br />
                            <br />
                            <br />
                            10. 一般條款<br />
                            <br />
                            10.1<br />
                            如果您違反了本使用條款的任何規定，或者您有合理的理由懷疑您已經違反了，我們將拒絕開立、暫停或關閉您的賬戶，並扣留獎金支付，並保留補償用戶賬戶餘額的權利。以上並不排除對用戶採取法律行動的權利，這在某些情況下被認為是適當的。<br />
                            <br />
                            10.2<br />
                            在線娛樂場世界解散或虛擬終止時，應提前通知用戶。收到通知後，マハラジャ 有責任履行由這些使用條款引起的義務，直至有效解散日期或結束日期。<br />
                            <br />
                            10.3<br />
                            本使用條款以提供信息和方便為目的，以多種語言發布，但本使用條款的日文版本將取代其他語言版本。<br />
                            <br />
                            10.4<br />
                            在不違反本使用條款的情況下，由於超出我們合理控制範圍的事件、事件或原因導致我們延遲或未履行本使用條款項下的義務，我們概不負責。<br />
                            <br />
                            10.5<br />
                            如果本使用條款的任何條款被確定為非法或不可執行，則該條款將與本使用條款分開。所有其他規定仍然有效，完全不受這種分離的影響。
                        </strong><br />
                        <br />
                        &nbsp;
                    </p>
                </div>
            </div>
        </div>

    </div>
</body>`;
                }

                $(divMessageBoxContent).html(rulesHtml);
                modal.toggle();
            } else {
                $(divMessageBoxContent).load(realPath, function () {
                    modal.toggle();
                });
            }
        }
    }
    
    function showLangProp() {

        if (EWinWebInfo.Lang=='JPN') {
        $('.lang-popup-list').eq(0).find('input').eq(0).prop("checked", true);
        } else {
        $('.lang-popup-list').eq(0).find('input').eq(1).prop("checked", true);
        }

        $('#ModalLanguage').modal('show');
    }


    window.onload = init;
</script>

<body class="mainBody vertical-menu">
    <div class="loader-container">
        <div class="loader-box">
            <div class="loader-spinner">
                <div class="sk-fading-circle">
                    <div class="loader-logo"></div>
                    <div class="sk-circle1 sk-circle"></div>
                    <div class="sk-circle2 sk-circle"></div>
                    <div class="sk-circle3 sk-circle"></div>
                    <div class="sk-circle4 sk-circle"></div>
                    <div class="sk-circle5 sk-circle"></div>
                    <div class="sk-circle6 sk-circle"></div>
                    <div class="sk-circle7 sk-circle"></div>
                    <div class="sk-circle8 sk-circle"></div>
                    <div class="sk-circle9 sk-circle"></div>
                    <div class="sk-circle10 sk-circle"></div>
                    <div class="sk-circle11 sk-circle"></div>
                    <div class="sk-circle12 sk-circle"></div>
                </div>
                <%--<div class="loader-text language_replace">正在加載...</div>--%>
            </div>
        </div>
        <div class="loader-backdrop is-show"></div>
    </div>
    <header class="header_area" id="">
        <div class="header_menu ">
            <!-- class="navbar-expand-xl" trigger hidden -->
            <nav class="navbar">
                <!-- TOP Search-->
                <div class="search-full" id="header_SearchFull">
                    <div class="container-fluid">
                        <form class="search__wrapper">
                            <div class="form-group-search search-plusbutton">
                                <input id="" type="search" class="form-control custom-search" name="search" language_replace="placeholder" placeholder="輸入帳號">
                                <label for="search" class="form-label"><span class="language_replace">輸入帳號</span></label>
                                <div class="btn btnSearch"><span class="language_replace">搜尋</span></div>
                                <button type="reset" class="btn btnReset"><i class="icon icon-ewin-input-reset"></i></button>
                            </div>
                            <span class="btn btn__closefullsearch" onclick="SearchControll.closeFullSearch(this)"><i class="icon icon-ewin-input-compress"></i></span>
                        </form>
                    </div>
                </div>
                <div class="container-fluid navbar__content">
                    <!--MENU BUTTON -->                    
                    <button id="navbar_toggler" class="navbar-toggler is-hide" type="button" data-toggle="collapse" data-target="#navbarMenu" aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
                         <!-- 通知小紅點-手機版時加入 -->
                        <div class="notify-dot mobile-notify-dot" style="display:none;"></div>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                   
                   
                    <!-- 頂部 NavBar -->
                    <div class="header_topNavBar">
                        <!-- 左上角 -->
                        <div class="header_leftWrapper navbar-nav" onclick="">
                            <div class="navbar-brand">
                                <div class="logo"><a></a></div>
                            </div>
                        </div>
                        <div id="headerGameDetailContent" style="display: none;">
                            <!-- Search -->
                            <ul class="nav header_setting_content">
                                <li class="headerGameDetail navbar-search nav-item">
                                    <button id="closeGameBtn" type="button" onclick="CloseGameFrame()" data-toggle="tooltip" data-placement="bottom" class="btn btn-search" style="background: white;">
                                        <i class="icon">X</i>
                                    </button>
                                    <span class="headerGameName"></span>

                                </li>
                            </ul>
                        </div>
                        <!-- 右上角 -->
                        <div class="header_rightWrapper">

                            <div class="header_setting">
                                <ul class="nav header_setting_content">
                                    
                                    <!-- ==== 登入前 ====-->
                                    <li class="nav-item unLogIn_wrapper " id="idLoginBtn">
                                        <ul class="horiz-list">
                                            <li class="login">
                                                <button class="btn-login btn" type="button" onclick="showUserLogInModal()" data-toggle="modal">
                                                    <span class="avater">
                                                        <img src="images/avatar/avater-2.png" alt=""></span>
                                                    <span class="language_replace" id="idUserLogInBtn">登入</span></button>
                                            </li>
                                            <li class="register">
                                                <button class="btn-register btn " type="button" onclick="showCreateAccountModal()" data-toggle="modal"><span class="language_replace">註冊</span></button>
                                            </li>
                                        </ul>
                                    </li>
                                    <!--  ==== 登入後 ====-->
                                    <li class="nav-item logIned_wrapper is-hide" id="idMenuLogin">
                                        <ul class="horiz-list">
                                            <li class="nav-item login">
                                                <button class="btn-logout btn" type="button" onclick="logout(true)">
                                                    <span class="avater">
                                                        <img src="images/avatar/avater-2.png" alt=""></span>
                                                    <span class="language_replace">登出</span></button>
                                            </li>
                                            <!-- User -->
                                            <!-- <li class="nav-item submenu dropdown avater_wrapper">
                                                <a onclick="API_LoadPage('MemberCenter', 'MemberCenter.aspx', true)" class="btn nav-link btnDropDown " role="button">
                                                    <span class="avater">
                                                        <span class="avater-img">
                                                            <img src="images/avatar/avater-2.png" alt="">
                                                        </span>
                                                        <span class="avater-name">kevin@kingkey.com.tw</span>
                                                    </span>
                                                </a>
                                            </li> -->
                                        </ul>
                                    </li>

                                    <!-- 語系 -->
                                    <li class="nav-item lang_wrapper submenu dropdown is-hide" style="display:none">
                                        <button type="button" class="btn nav-link btn-langExchange" data-toggle="modal" data-target="#ModalLanguage" id="btn_switchlang">
                                            <!-- 語系 轉換 ICON -->
                                            <%--<i class="icon icon-mask icon-flag-JP"></i>
                                            <i class="icon icon-mask icon-flag-EN"></i>
                                            <i class="icon icon-mask icon-flag-ZH"></i>--%>
                                        </button>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <div id="mask_overlay" class="mask_overlay"></div>
    </header>
    <div class="main_area">
        <section class="section-main-banner">
            <div class="hero-wrapper">
                <div class="hero-item mobile">
                    <div class="img-wrap"><img src="images/main-banner-m.jpg" alt=""></div>
                </div>
                <div class="hero-item desktop">
                    <div class="img-wrap"><img src="images/main-banner.jpg" alt=""></div>
                </div>
            </div>
        </section>
        <!-- 各分類-單一遊戲推薦區 -->
        <section class="section-category-dailypush">
            <div class="container">                
                <!-- hot -->
                <div class="category-dailypush-wrapper hot">
                    <div class="category-dailypush-inner">
                        <div class="category-dailypush-img" style="background-color: #121a16;">
                            <div class="img-box mobile">
                                <div class="img-wrap">
                                    <img src="/images/lobby/dailypush-hot-M-001.jpg" alt="">
                                </div>
                            </div>
                            <div class="img-box pad">
                                <div class="img-wrap">
                                    <img src="/images/lobby/dailypush-hot-MD-001.jpg" alt="">
                                </div>
                            </div>
                            <div class="img-box desktop">
                                <div class="img-wrap">
                                    <img src="/images/lobby/dailypush-hot-001.jpg" alt="">
                                </div>
                            </div>
                        </div>
                        <div class="category-dailypush-cotentBox">
                            <div class="category-dailypush-cotent">
                                <h2 class="title language_replace">本日優選推薦</h2>
                                <div class="info">
                                    <h3 class="gamename language_replace">叢林之王-集鴻運</h3>
                                    <div class="detail">
                                        <span class="gamebrand language_replace">BNG</span>
                                        <span class="gamecategory language_replace">Slot</span>
                                    </div>
                                </div>
                            
                                <div class="action">
                                    <button class="btn btn-play" onclick="openHeaderGame()"><span class="language_replace">進入遊戲</span></button>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                          
            </div>
        </section>

         <!-- 遊戲推薦區 -->
         <section class="section-gamesArea">
            <div class="container">
                <div class="game-list" id="gameList">
                    
                 <%--   <div class="wrapper_center">
                        <div class="btn btn-more" onclick="">查看更多</div>
                    </div>--%>
                </div>
            </div>
         </section>

           <!-- 介紹說明 -->
          <section class="section-webDesc">
            <div class="container">
                <div class="section-Wrapper">
                    <h2 class="sec-webDesc-title language_replace">Maharaja無料版 首次登場</h2>
                    <p class="language_replace">不論是從未玩過Maharaja遊戲的初學者，還是想知道Maharaja有那些遊戲的人，現在都可以不必擔心負擔任何費用，輕鬆地在Maharaja無料版享受免費遊戲。</p>
                    <p class="language_replace">Maharaja無料版是一個完全免費的遊戲網站，因此任何人都能盡情享受其樂趣！</p>
                </div>
                <div class="section-Wrapper">
                    <h2 class="sec-webDesc-title language_replace">可以玩的遊戲類型？</h2>
                    <p class="language_replace">Maharaja免費版能夠遊玩60種類以上的遊戲。除了令人雀躍的特效讓人欲罷不能的老虎機以外，還有輪盤和二十一點等高人氣桌面遊戲一應俱全。</p>
                    <ul class="game-type-list">
                        <li class="game-type-item">
                            <div class="img-crop">
                                <img src="images/icon/icon-slot-red.svg" alt="">
                            </div>
                            <h3 class="game-type-name language_replace">免費版老虎機</h3>
                            <p class="game-type-desc language_replace">老虎機是 Maharaja無料版 最受歡迎的遊戲之一，華麗感十足的酷炫效果，還可以贏得夢幻般大量的紅利獎金，都是老虎機這款遊戲的魅力所在。只需要點擊『SPIN』按鈕就可以開始遊戲，非常的容易操作。因此很推廌給所有的初學者。</p>
                        </li>
                        <li class="game-type-item">
                            <div class="img-crop">
                                <img src="images/icon/icon-poker-red.svg" alt="">
                            </div>
                            <h3 class="game-type-name language_replace">免費版桌遊</h3>
                            <p class="game-type-desc language_replace">桌面遊戲也是Maharaja免費版中非常受歡迎的遊戲之一，主要有使用撲克牌進行的遊戲，和使用有數字的圓盤遊玩的輪盤等。除了能用自己的步調一人遊玩的類型外，也可以選擇由荷官主持的桌面遊戲。可以依照自己的喜好去玩。</p>
                        </li>
                    </ul>
                </div>
                <div class="section-Wrapper">
                    <h2 class="sec-webDesc-title language_replace">隨時隨地享受遊戲的樂趣！</h2>
                    <p class="sec-webDesc-subtitle language_replace">在Maharaja無料版中，只需點擊您感興趣的遊戲即可開始免費遊玩，非常簡單好上手！</p>
                    <p class="language_replace">除了可以在個人電腦上玩之外，您隨時隨地都能使用智慧手機或平板電腦輕鬆體驗其中的樂趣。請盡情享受Maharaja無料版的遊戲吧！</p>
                </div>
                <div class="section-Wrapper">
                    <h2 class="sec-webDesc-title language_replace">註冊簡單又快速！</h2>
                    <p class="language_replace">只需點擊『免費註冊』，輸入您的電子郵件和密碼，簡單的幾個步驟就可以快速的完成註冊。</p>
                    <p class="language_replace">花費不到一分鐘的時間，立刻暢玩Maharaja無料版中的所有遊戲！</p>
                </div>
            </div>
          </section>
    </div>
    <!-- footer -->
    <div id="footer">
        <footer class="footer-container">
            <div class="footer-inner">
                <div class="container">
                    <ul class="company-info row">
                        <li class="info-item col">
                            <a id="Footer_About" onclick="showPartialHtml('','About', true, null)"><span class="language_replace">關於我們</span></a>
                        </li>
                       
                        <!-- <li class="info-item col">
                            <a onclick="window.parent.API_ShowContactUs()">
                                <span class="language_replace">聯絡客服</span>
                            </a>
                        </li> -->
                       
                        <li class="info-item col">
                            <a id="Footer_ResponsibleGaming" onclick="showPartialHtml('', 'ResponsibleGaming', true, null)">
                                <span class="language_replace">負責任的賭博</span>
                            </a>
                        </li>
                        <li class="info-item col">
                            <a id="Footer_Rules" onclick="showPartialHtml('', 'Rules', true, null)">
                                <span class="language_replace">利用規約</span>
                            </a>
                        </li>
                        <li class="info-item col">
                            <a id="Footer_PrivacyPolicy" onclick="showPartialHtml('', 'PrivacyPolicy', true, null)">
                                <span class="language_replace">隱私權政策</span>
                            </a>
                        </li>
                        <!-- <li class="info-item col" id="li_HotArticle">
                            <a onclick="openHotArticle()">
                                <span class="language_replace">熱門文章</span>
                            </a>
                        </li> -->
                    </ul>
                    <div class="partner">
                        <div class="logo">
                            <div class="row">
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-eWIN.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-microgaming.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-kgs.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-bbin.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-gmw.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-cq9.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-red-tiger.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-evo.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-bco.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-cg.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-playngo.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-pg.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-netent.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-kx.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-evops.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-bti.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-zeus.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-biggaming.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-play.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-h.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-va.png" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="company-detail">
                        <div class="company-address">
                            <p class="address language_replace">MAHARAJA由(Online Chip World Co. N.V) 所有並營運。（註冊地址：Zuikertuintjeweg Z/N (Zuikertuin Tower), Willemstad, Curacao）取得庫拉索政府核發的執照 註冊號碼：#365 / JAZ 認可，並以此據為標準。</p>
                        </div>
                    </div>
                    <div class="footer-lang">
                        <div class="input-fake-select" onclick="showLangProp()">
                            <div class="lang-list">
                                <div class="lang-item">
                                    <!-- icon-flag-JP/icon-flag-ZH 切換-->
                                    <i id="footerLangIcon" class="icon icon-mask"></i>
                                    <span id="footerLangText" class="lang-name language_replace"></span>
                                </div>
                            </div>
                            <div class="has-arrow"><i class="arrow"></i></div>
                        </div>
                    </div>
                    <div class="footer-copyright">
                        <p class="language_replace">Copyright © 2022 マハラジャ. All Rights Reserved.</p>
                    </div>
                </div>
            </div>
        </footer>
    </div>
    
      <!-- Modal Login/Register -->
      <div class="modal fade show customHeader" id="ModalUserLogIn" tabindex="-1" aria-hidden="true" style="display: ;">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_PupLangClose">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                     <!-- 登入 TAB-->
                    <input type="radio" name="tabType" value="0" class="tabTypeInput userLogin" id="userLogin">
                    <label for="userLogin" class="tabTypeLabel userLogin language_replace">登入</label>
                    <!-- 註冊 TAB-->
                    <input type="radio" name="tabType" value="1" class="tabTypeInput userRegister" id="userRegister">
                    <label for="userRegister" class="tabTypeLabel userRegister language_replace">註冊</label>
                    <div class="tracking-bar"></div>

                    <div class="content-wrapper wrapper-full">
                         <!-- 登入 -->
                           <form method="post" id="idFormUserLogin">

                               <div class="content-inner login-wrapper">
                                  <div class="content-inner-body">
                                    <div class="form-group">
                                        <label class="form-title language_replace">電子信箱</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" language_replace="placeholder"
                                                placeholder="電子信箱" name="LoginAccount">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-title language_replace">密碼</label>
                                        <div class="input-group">
                                            <input id="login_Password" type="password" class="form-control"
                                                language_replace="placeholder" placeholder="密碼" name="LoginPassword">
                                        </div>
                                        <div class="input-group-append">
                                            <button class="btn btn-icon btn-transparent btn-checkpwd" type="button"
                                                onclick="eyeTogger()">
                                                <!-- class切換=>icon-eye-off/icon-eye -->
                                                <i id="eyeTogger_i" class="icon-moon icon-eye-off"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="wrapper_center">
                                        <button class="btn btn-full-main btn-roundcorner btn-popup-login" type="button"
                                            onclick="onBtnSendLogin()">
                                            <span class="language_replace">登入</span>
                                        </button>
                                    </div>
                                  </div>

                                  <div class="content-inner-footer">
                                    
                                  </div>
                               </div>
                           </form>
                    

                        <!-- 註冊 -->
                        <div class="content-inner register-wrapper">
                            <div class="content-inner-body">
                                <div class="form-group">
                                    <label class="form-title language_replace">電子信箱</label>
                                    <div class="input-group">
                                        <input id="createAccount_Mail" type="text" class="form-control" language_replace="placeholder" placeholder="電子信箱" onkeyup="">
                                    </div>
                                    <div class="input-group-append">
                                        <button onclick="onBtnSendValidateCode()" id="divSendValidateCodeBtn" class="btn btn-icon btn-full-main btn-sendCode" type="button"><span class="language_replace">發送驗證碼</span></button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-title language_replace">驗證碼</label>
                                    <div class="input-group">
                                        <input id="createAccount_ValidateCode" type="text" class="form-control" language_replace="placeholder" placeholder="驗證碼" onkeyup="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-title language_replace">密碼</label>
                                    <div class="input-group">
                                        <input id="createAccount_Password" type="password" class="form-control" language_replace="placeholder" placeholder="密碼" onkeyup="">
                                    </div>
                                    <div class="input-group-append">
                                        <button class="btn btn-icon btn-transparent btn-checkpwd" type="button" onclick="eyeTogger2()">
                                            <!-- class切換=>icon-eye-off/icon-eye -->
                                            <i id="eyeTogger2_i" class="icon-moon icon-eye-off"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="form-title language_replace">暱稱（部分遊戲遊玩時顯示使用）</label>
                                    <div class="input-group">
                                        <input id="createAccount_NickName" type="text" class="form-control" language_replace="placeholder" placeholder="請輸入暱稱" onkeyup="">
                                    </div>
                                </div>
                                <div class="must-mark">
                                    <div class="custom-control custom-checkboxValue text-sm">
                                        <label class="custom-label">
                                            <input type="checkbox" name="chkCreateAccount1" class="custom-control-input-hidden" onclick="" value="" >
                                            <div class="custom-input checkbox"><span class="language_replace"><span class="language_replace">我已年滿20歲，並且已閱讀並同意 利用規約和隱私政策。</span></div>
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkboxValue text-sm">
                                        <label class="custom-label">
                                            <input type="checkbox" name="chkCreateAccount2" class="custom-control-input-hidden" onclick="" value="" >
                                            <div class="custom-input checkbox"><span class="language_replace">我同意通過我註冊的電子郵件地址接收來自第三方的活動信息和信息</span></div>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="content-inner-footer">
                                <div class="wrapper_center">
                                    <button class="btn btn-full-main btn-roundcorner btn-popup-register" type="button" onclick="createAccount()">
                                        <span class="language_replace">註冊</span>
                                    </button>
                                </div>
                            </div>
                        </div> 
                    </div>        
                </div>
                <!-- <div class="modal-footer">
                    <button type="button" class="btn btn-primary">確定</button>
                </div> -->
            </div>
        </div>
    </div>

     <!-- Modal Language -->
     <div class="modal fade footer-center" id="ModalLanguage" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><span class="language_replace">請選擇語言</span></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_PupLangClose">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="lang-popup-wrapper">
                        <ul class="lang-popup-list">
                            <li class="lang-item custom-control custom-radioValue-lang" onclick="switchLang('JPN', true)">
                                <label class="custom-label">
                                    <input type="radio" name="button-langExchange" class="custom-control-input-hidden"
                                        checked>
                                    <div class="custom-input radio-button">
                                        <span class="flag JP"><i class="icon icon-mask icon-flag-JP"></i></span>
                                        <span class="name">日本語</span>
                                    </div>
                                </label>
                            </li>
                            <%--<li class="lang-item custom-control custom-radioValue-lang" onclick="switchLang('ENG', true)">
                                <label class="custom-label">
                                    <input type="radio" name="button-langExchange" class="custom-control-input-hidden">
                                    <div class="custom-input radio-button">
                                        <span class="flag EN"><i class="icon icon-mask icon-flag-EN"></i></span>
                                        <span class="name">English</span>
                                    </div>
                                </label>
                            </li>--%>
                            <li class="lang-item custom-control custom-radioValue-lang" onclick="switchLang('CHT', true)">
                                <label class="custom-label">
                                    <input type="radio" name="button-langExchange" class="custom-control-input-hidden">
                                    <div class="custom-input radio-button">
                                        <span class="flag ZH"><i class="icon icon-mask icon-flag-ZH"></i></span>
                                        <span class="name">繁體中文</span>
                                    </div>
                                </label>
                            </li>
                        </ul>
                    </div>


                </div>
                <%--<div class="modal-footer">
                    <button type="button" class="btn btn-primary">確定</button>
                </div>--%>
            </div>
        </div>
    </div>


     <!--alert Msg-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertMsg" aria-hidden="true" id="alertMsg" style="z-index: 10000;">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><%--<i class="icon-close-small is-hide"></i>--%></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <i class="icon-error_outline primary"></i>
                        <div class="text-wrap">
                            <p class="alertMsg_Text language_replace">變更個人資訊，請透過客服進行 ！</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alertMsg_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                        <button type="button" class="alertMsg_Close btn btn-outline-primary btn-sm" data-dismiss="modal"><span class="language_replace">取消</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--alert-->

     <!-- 滿版遊戲介面 -->
    <div id="divGameFrame" class="divGameFrameBody" style="display:none;">
        <div class="divGameFrameWrapper">
            <div class="btn-wrapper">
                <div class="btn btn-game-close" onclick="CloseGameFrame()"><i class="icon icon-mask icon-error"></i></div>
            </div>
            <iframe id="GameIFramePage" class="divGameFrame" name="mainiframe" sandbox="allow-same-origin allow-scripts allow-popups allow-forms allow-pointer-lock"></iframe>
        </div>
    </div>
    <!-- 滿版遊戲介面 end-->

    
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="alertPartialHtml" aria-hidden="true" id="alertPartialHtml">
        <div class="modal-dialog modal-lg modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-title alertPartialHtml_Title">
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content alertPartialHtml_Content">
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-container">
                        <button type="button" class="alertPartialHtml_OK btn btn-primary btn-sm" data-dismiss="modal"><span class="language_replace">確定</span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
