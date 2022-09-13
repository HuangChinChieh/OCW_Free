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
            Response.Write("<script> var defaultError = function(){ showMessageOK('', mlp.getLanguageKey('登入失敗') + ' ' +  mlp.getLanguageKey('" + LoginAPIResult.Message + "'),function () { })};</script>");
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
    <meta name='description' content="知名なオンラインゲームブランドを提携し、信頼価値もあるし、それにすぐ遊べることができます。お金の無駄遣いをせずに、今すぐサイトを登録して、ゲーム開始！" />
    <meta property="og:site_name" content="マハラジャ" />
    <meta property="og:title" content="一番人気なオンラインカジノアミューズメント - マハラジャ" />
    <meta property="og:Keyword" content="カジノ、スロット、アミューズメント、ゲーム、ギャンブル" />
    <meta property="og:description" content="知名なオンラインゲームブランドを提携し、信頼価値もあるし、それにすぐ遊べることができます。お金の無駄遣いをせずに、今すぐサイトを登録して、ゲーム開始！" />
    <meta property="og:url" content="https://casino-maharaja.com/" />
    <!--日文圖片-->
    <meta property="og:image" content="https://casino-maharaja.com/images/share_pic.png" />
    <meta property="og:type" content="website" />
    <!-- Share image -->
    <!--日文圖片-->
    <link rel="image_src" href="https://casino-maharaja.com/images/share_pic.png">
    <link rel="shortcut icon" href="images/share_pic.png">
    <link rel="stylesheet" href="css/basic.min.css">
    <link rel="stylesheet" href="css/icons.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/lobby.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;500&display=swap" rel="Prefetch" as="style" onload="this.rel = 'stylesheet'" />

    <link rel="alternate" hreflang="ja" href="https://casino-maharaja.com/index.aspx?Lang=JPN">
    <link rel="alternate" hreflang="ja-jp" href="https://casino-maharaja.com/index.aspx?Lang=JPN">
    <link rel="alternate" hreflang="zh-cn" href="https://casino-maharaja.com/index.aspx?Lang=CHT">
    <link rel="alternate" hreflang="zh-tw" href="https://casino-maharaja.com/index.aspx?Lang=CHT">
    <link rel="alternate" hreflang="zh" href="https://casino-maharaja.com/index.aspx?Lang=CHT">
    <link rel="alternate" hreflang="zh-hk" href="https://casino-maharaja.com/index.aspx?Lang=CHT">
    
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
            GameName: '33',
            GameBrand: 'KGS',
            GameLangNameCHT: '夜店',
            GameLangNameJPN: '夜店',
            NeedLogin: false
        }, {
            GameName: 'GonzoTH000000001',
            GameBrand: 'EVO',
            GameLangNameCHT: '岡佐的尋寶之旅',
            GameLangNameJPN: '岡佐的尋寶之旅',
            NeedLogin: false
        }, {
            GameName: '254',
            GameBrand: 'BNG',
            GameLangNameCHT: '黑狼-集鴻運',
            GameLangNameJPN: '黑狼-集鴻運',
            NeedLogin: false
        }, {
            GameName: '18',
            GameBrand: 'PG',
            GameLangNameCHT: '逆襲的小紅帽',
            GameLangNameJPN: '逆襲的小紅帽',
            NeedLogin: false
        }, {
            GameName: '1187',
            GameBrand: 'BBIN',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '1336',
            GameBrand: 'BBIN',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '76',
            GameBrand: 'BBIN',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '202',
            GameBrand: 'BNG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '219',
            GameBrand: 'BNG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '242',
            GameBrand: 'BNG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '256',
            GameBrand: 'BNG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '187',
            GameBrand: 'BNG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '275',
            GameBrand: 'BNG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: '271',
            GameBrand: 'BNG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: 'DuoFuDuoCaiDiamondEternity',
            GameBrand: 'CG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: 'GeishaEX',
            GameBrand: 'CG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        }, {
            GameName: 'LuckyPig',
            GameBrand: 'CG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },{
            GameName: 'Baccarat2',
            GameBrand: 'CG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: 'InternationalSicbo',
            GameBrand: 'CG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: 'Wheel',
            GameBrand: 'CG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '115',
            GameBrand: 'CQ9',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '186',
            GameBrand: 'CQ9',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '206',
            GameBrand: 'CQ9',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '3',
            GameBrand: 'CQ9',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '54',
            GameBrand: 'CQ9',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '889',
            GameBrand: 'GMW',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '917',
            GameBrand: 'GMW',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '925',
            GameBrand: 'GMW',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '755',
            GameBrand: 'HB',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '757',
            GameBrand: 'HB',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '3',
            GameBrand: 'KGS',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '32',
            GameBrand: 'KGS',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '8',
            GameBrand: 'KGS',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '5',
            GameBrand: 'KGS',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '15',
            GameBrand: 'KGS',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '348',
            GameBrand: 'MG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '359',
            GameBrand: 'MG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '367',
            GameBrand: 'MG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '387',
            GameBrand: 'MG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '400',
            GameBrand: 'MG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
        {
            GameName: '426',
            GameBrand: 'MG',
            GameLangNameCHT: '',
            GameLangNameJPN: '',
            NeedLogin: true
        },
    ];

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
        mlp = new multiLanguage();
        appendGameItem();
        mlp.loadLanguage(EWinWebInfo.Lang, function () {

            lobbyClient = new LobbyAPI("/API/LobbyAPI.asmx");

            appendGameFrame();

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
                                API_Logout(true);
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
        BtnSend.innerText = mlp.getLanguageKey("驗證碼");
        isSent = false;
    }

    function onBtnSendValidateCode() {
        if (isSent == false) {
            var mail = $('#createAccount_Mail').val().trim();
            validateEmail(mail, function (success) {
                if (success) {
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
            window.parent.showMessageOK("", mlp.getLanguageKey("已發送驗證碼，短時間內請勿重複發送"));
        }
    }

    function createAccount() {
        var password = $('#createAccount_Password').val().trim();
        var validateCode = $('#createAccount_ValidateCode').val().trim();
        var mail = $('#createAccount_Mail').val().trim();
        var CurrencyList = EWinWebInfo.RegisterCurrencyType;
        if (validateCode == "") {
            showMessageOK("", mlp.getLanguageKey("驗證碼尚未填寫"));
            return false;
        }

        if (password=="") {
            showMessageOK("", mlp.getLanguageKey("密碼尚未填寫"));
            return false;
        }

        if (mail == "") {
            showMessageOK("", mlp.getLanguageKey("EMail尚未填寫"));
            return false;
        }

        if (!$("input[name='chkCreateAccount1']").prop("checked")) {
            showMessageOK("", mlp.getLanguageKey("尚未勾選"));
            return false;
        }

        if (!$("input[name='chkCreateAccount2']").prop("checked")) {
            showMessageOK("", mlp.getLanguageKey("尚未勾選"));
            return false;
        }

        var PS = [
            { Name: "EMail", Value: mail }
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
                                    $('#ModalUserLogIn').modal('hide');
                                });
                            } else {
                                window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey(o.Message), function () {

                                });
                            }
                        } else {
                            if (o == "Timeout") {
                                window.parent.showMessageOK(mlp.getLanguageKey("失敗"), mlp.getLanguageKey("網路異常, 請重新嘗試"), function () {

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

    function openGame(gameBrand, gameName, gameLangName) {

        //先關閉Game彈出視窗(如果存在)
        if (gameWindow) {
            gameWindow.close();
        }
        var SID = "";

        if (!EWinWebInfo.UserLogined) {
            lobbyClient.GetFreeUserAccount(Math.uuid(), function (success, o) {
                if (success) {
                    if (o.Result == 0) {
                        SID = o.Message;
                        openGameStep2(gameBrand, gameName, gameLangName, SID);
                    } else {
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("測試人數已滿,請稍後再試"));
                    }
                }
                else {
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
                        showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("服務器異常, 請稍後再嘗試一次"), function () {
                            window.location.href = "index.aspx"
                        });
                    }
                }
                else {
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
            gameWindow = window.open("/OpenGame.aspx?SID=" + SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + EWinWebInfo.MainCurrencyType + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + "<%=EWinWeb.CasinoWorldUrl%>/CloseGame.aspx" + "&CT=" + EWinWebInfo.CT, "Maharaja Game")
            } else {
                if (EWinWebInfo.DeviceType == 1) {
                    gameWindow = window.open("/OpenGame.aspx?SID=" + SID + "&Lang=" + EWinWebInfo.Lang + "&CurrencyType=" + EWinWebInfo.MainCurrencyType + "&GameBrand=" + gameBrand + "&GameName=" + gameName + "&HomeUrl=" + "<%=EWinWeb.CasinoWorldUrl%>/CloseGame.aspx", "Maharaja Game");

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
        for (var i = 0; i < jsonGames.length; i++) {
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
                            <div class="game-item-link" onclick="openGame('${data.GameBrand}','${data.GameName}','${gamelangName}')" onmouseover="">
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

    window.onload = init;
</script>

<body class="mainBody vertical-menu">
    <div class="loader-container" style="display: none;">
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
            <div class="img-wrap"><img src="images/main-banner.jpg" alt=""></div> 
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
                                        <span class="gamebrand">BNG</span>
                                        <span class="gamecategory">老虎機</span>
                                    </div>
                                </div>
                                <div class="intro language_replace is-hide">
                                    遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹遊戲介紹
                                </div>
                                <div class="action">
                                    <button class="btn btn-play" onclick="window.parent.openGame('BNG', '242','叢林之王-集鴻運')"><span class="language_replace">進入遊戲</span></button>
                                    
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
    </div>
    <!-- footer -->
    <div id="footer">
        <footer class="footer-container">
            <div class="footer-inner">
                <div class="container">
                    <ul class="company-info row">
                        <li class="info-item col">
                            <a id="Footer_About" onclick="window.parent.API_LoadPage('About','About.html')"><span class="language_replace">關於我們</span></a>
                        </li>
                       
                        <!-- <li class="info-item col">
                            <a onclick="window.parent.API_ShowContactUs()">
                                <span class="language_replace">聯絡客服</span>
                            </a>
                        </li> -->
                       
                        <li class="info-item col">
                            <a id="Footer_ResponsibleGaming" onclick="window.parent.API_ShowPartialHtml('', 'ResponsibleGaming', true, null)">
                                <span class="language_replace">負責任的賭博</span>
                            </a>
                        </li>
                        <li class="info-item col">
                            <a id="Footer_Rules" onclick="window.parent.API_ShowPartialHtml('', 'Rules', true, null)">
                                <span class="language_replace">利用規約</span>
                            </a>
                        </li>
                        <li class="info-item col">
                            <a id="Footer_PrivacyPolicy" onclick="window.parent.API_ShowPartialHtml('', 'PrivacyPolicy', true, null)">
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
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-pagcor.png" alt="">
                                    </div>
                                </div>
                                <div class="logo-item">
                                    <div class="img-crop">
                                        <img src="/images/logo/footer/logo-mishuha.png" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="company-detail">
                        <!-- <div class="company-license">
                            <iframe src="https://licensing.gaming-curacao.com/validator/?lh=73f82515ca83aaf2883e78a6c118bea3&template=tseal" width="150" height="50" style="border: none;"></iframe>
                        </div> -->
                        <div class="company-address">
                            <p class="address language_replace">MAHARAJA由(Online Chip World Co. N.V) 所有並營運。（註冊地址：Zuikertuintjeweg Z/N (Zuikertuin Tower), Willemstad, Curacao）取得庫拉索政府核發的執照 註冊號碼：#365 / JAZ 認可，並以此據為標準。</p>
                        </div>
                    </div>
                    <div class="footer-copyright">
                        <p class="language_replace">Copyright © 2022 マハラジャ. All Rights Reserved.</p>
                    </div>
                </div>
            </div>
        </footer>
    </div>
      <!-- Modal Language -->
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
                    <label for="userLogin" class="tabTypeLabel userLogin">登入</label>
                    <!-- 註冊 TAB-->
                    <input type="radio" name="tabType" value="1" class="tabTypeInput userRegister" id="userRegister">
                    <label for="userRegister" class="tabTypeLabel userRegister">註冊</label>
                    <div class="tracking-bar"></div>

                    <div class="content wrapper-full">
                         <!-- 登入 -->
                           <form method="post" id="idFormUserLogin">
                                   <div class="login-wrapper ">
                            <div class="form-group">
                                <label class="form-title language_replace">電子信箱</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" language_replace="placeholder" placeholder="電子信箱" name="LoginAccount">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-title language_replace">密碼</label>
                                <div class="input-group">
                                    <input id="login_Password" type="password" class="form-control" language_replace="placeholder" placeholder="密碼" name="LoginPassword">
                                </div>
                                <div class="input-group-append">
                                    <button class="btn btn-icon btn-transparent btn-checkpwd" type="button" onclick="$('#login_Password').attr('type','text')">
                                        <!-- class切換=>icon-eye-off/icon-eye -->
                                        <i class="icon-moon icon-eye-off"></i>
                                    </button>
                                </div>
                            </div>
                   
                            <div class="wrapper_center">
                                <button class="btn btn-full-main btn-roundcorner btn-popup-login" type="button" onclick="onBtnSendLogin()">
                                    <span class="language_replace">登入</span>
                                </button>
                            </div>

                        </div>
                           </form>
                    

                        <!-- 註冊 -->
                        <div class="register-wrapper">
                            <div class="form-group">
                                <label class="form-title language_replace">電子信箱</label>
                                <div class="input-group">
                                    <input id="createAccount_Mail" type="text" class="form-control" language_replace="placeholder" placeholder="電子信箱" onkeyup="">
                                </div>
                                <div class="input-group-append">
                                    <button onclick="onBtnSendValidateCode()" id="divSendValidateCodeBtn" class="btn btn-icon btn-full-main btn-sendCode" type="button" onclick=""><span class="language_replace">發送驗證碼</span></button>
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
                                    <button class="btn btn-icon btn-transparent btn-checkpwd" type="button" onclick="$('#createAccount_Password').attr('type','text')">
                                        <!-- class切換=>icon-eye-off/icon-eye -->
                                        <i class="icon-moon icon-eye-off"></i>
                                    </button>
                                </div>
                            
                            </div>
                            <div class="must-mark">
                                <div class="custom-control custom-checkboxValue text-sm">
                                    <label class="custom-label">
                                        <input type="checkbox" name="chkCreateAccount1" class="custom-control-input-hidden" onclick="" value="" >
                                        <div class="custom-input checkbox"><span class="language_replace">我已年滿18歲，並且已閱讀並同意 <span class="">MAHARAJA服務條款</span> 和 <span class="">隱私政策。</span></span></div>
                                    </label>
                                </div>
                                <div class="custom-control custom-checkboxValue text-sm">
                                    <label class="custom-label">
                                        <input type="checkbox" name="chkCreateAccount2" class="custom-control-input-hidden" onclick="" value="" >
                                        <div class="custom-input checkbox"><span class="language_replace">我同意通過我註冊的電子郵件地址接收來自第三方的活動信息和信息</span></div>
                                    </label>
                                </div>
                            </div>  
                            <div class="wrapper_center">
                                <button class="btn btn-full-main btn-roundcorner btn-popup-register" type="button" onclick="createAccount()">
                                    <span class="language_replace">註冊</span>
                                </button>
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
    <div id="divGameFrame" class="divGameFrameBody">
        <div class="divGameFrameWrapper">
            <div class="btn-wrapper">
                <div class="btn btn-game-close" onclick="CloseGameFrame()"><i class="icon icon-mask icon-error"></i></div>
            </div>
            <iframe id="GameIFramePage" class="divGameFrame" name="mainiframe" sandbox="allow-same-origin allow-scripts allow-popups allow-forms allow-pointer-lock"></iframe>
        </div>
    </div>
    <!-- 滿版遊戲介面 end-->
</body>
</html>
