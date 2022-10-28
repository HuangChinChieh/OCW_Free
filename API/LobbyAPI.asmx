<%@ WebService Language="C#" Class="LobbyAPI" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Linq;
using System.Threading.Tasks;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
// [System.Web.Script.Services.ScriptService]
[System.ComponentModel.ToolboxItem(false)]
[System.Web.Script.Services.ScriptService]
public class LobbyAPI : System.Web.Services.WebService
{

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.UserInfoResult GetUserInfo(string WebSID, string GUID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetUserInfo(GetToken(), WebSID, GUID);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult KeepSID(string SID, string GUID)
    {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult();

        R = lobbyAPI.KeepSID(GetToken(), SID, GUID);

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.CompanySiteResult GetCompanySite(string GUID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.GetCompanySite(GetToken(), GUID);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult DepositUserAccountPoint(string GUID, string SID) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.UserInfoResult userInfoResult = null;
        Newtonsoft.Json.Linq.JObject CallRet;
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result = EWin.Lobby.enumResult.ERR };
        decimal Balance = 0;
        decimal DepositAmount = 0;
        decimal SendAmount = 100000;
        string BasicURL = "http://ewin.dev.mts.idv.tw/API/ProductAPI.asmx";
        string BasicBodyString = "{\"Token\":\""+GetToken()+"\",\"GUID\":\"1234\"}";
        string TransID;
        Newtonsoft.Json.Linq.JObject SendBodyObj;

        userInfoResult = lobbyAPI.GetUserInfo(GetToken(), SID, GUID);
        if (userInfoResult.Result == EWin.Lobby.enumResult.OK)
        {
            Balance = userInfoResult.WalletList.First().PointValue;
            DepositAmount = SendAmount - Balance;

            TransID = System.Guid.NewGuid().ToString();
            SendBodyObj = Newtonsoft.Json.Linq.JObject.Parse(BasicBodyString);
            SendBodyObj.Add("LoginAccount", userInfoResult.LoginAccount);

            SendBodyObj.Add("TransactionCode", TransID);
            SendBodyObj.Add("CurrencyType", EWinWeb.MainCurrencyType);


            if (DepositAmount > 0) {
                SendBodyObj.Add("Amount", DepositAmount);

                CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountDeposit", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));
                if ((int)CallRet["d"]["ResultState"] == 0) {
                    CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountDepositConfirm", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));
                }
            } else if (DepositAmount < 0) {
                DepositAmount = DepositAmount * -1;
                SendBodyObj.Add("Amount", DepositAmount);

                CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountWithdrawal", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));
                if ((int)CallRet["d"]["ResultState"] == 0) {
                    CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountWithdrawalConfirm", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));
                }
            }

            R.Result = EWin.Lobby.enumResult.OK;
        }

        return R;
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult GetFreeUserAccount(string GUID) {
        Newtonsoft.Json.Linq.JObject CallRet;
        Newtonsoft.Json.Linq.JObject SendBodyObj;
        int AccountIndex = 0;
        string BasicURL = "http://ewin.dev.mts.idv.tw/API/ProductAPI.asmx";
        string BasicBodyString = "{\"Token\":\""+GetToken()+"\",\"GUID\":\"1234\"}";
        bool IsOnline = true;
        decimal DepositAmount;
        decimal SendAmount = 100000;
        string TransID;
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { Result= EWin.Lobby.enumResult.ERR };

        try {

            //1.check User Is Not Online

            SendBodyObj = Newtonsoft.Json.Linq.JObject.Parse(BasicBodyString);
            SendBodyObj.Add("LoginAccount", "");

            do {
                if (AccountIndex == 30) {
                    return null;
                }

                AccountIndex++;

                SendBodyObj["LoginAccount"] = "test" + AccountIndex.ToString();

                CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountIsOnline", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));

                if ((int)CallRet["d"]["ResultState"] == 0) {
                    IsOnline = (bool)CallRet["d"]["UserIsOnline"];
                } else {
                    IsOnline = false;
                }
            } while (IsOnline);

            //2.Check Balance And CreateUser

            SendBodyObj = Newtonsoft.Json.Linq.JObject.Parse(BasicBodyString);
            SendBodyObj.Add("LoginAccount", "test" + AccountIndex.ToString());

            CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountGetInfo", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));

            if ((int)CallRet["d"]["ResultState"] == 0) {
                DepositAmount = SendAmount - (decimal)CallRet["d"]["UserAccountWallet"][0]["Balance"];
            } else {
                DepositAmount = SendAmount;
            }

            TransID = System.Guid.NewGuid().ToString();

            SendBodyObj.Add("TransactionCode", TransID);
            SendBodyObj.Add("CurrencyType", EWinWeb.MainCurrencyType);


            if (DepositAmount > 0) {
                SendBodyObj.Add("Amount", DepositAmount);

                CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountDeposit", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));
                if ((int)CallRet["d"]["ResultState"] == 0) {
                    CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountDepositConfirm", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));
                }
            } else if (DepositAmount < 0) {
                DepositAmount = DepositAmount * -1;
                SendBodyObj.Add("Amount", DepositAmount);

                CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountWithdrawal", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));
                if ((int)CallRet["d"]["ResultState"] == 0) {
                    CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserAccountWithdrawalConfirm", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));
                }
            }

            //3.Login

            SendBodyObj = Newtonsoft.Json.Linq.JObject.Parse(BasicBodyString);
            SendBodyObj.Add("LoginAccount", "test" + AccountIndex.ToString());
            SendBodyObj.Add("UserIP", "");

            CallRet = Newtonsoft.Json.Linq.JObject.Parse(CodingControl.GetWebTextContent(BasicURL + "/UserLogin", "POST", SendBodyObj.ToString(Newtonsoft.Json.Formatting.None), null, "application/json"));

            if ((int)CallRet["d"]["ResultState"] == 0) {
                R.Message = CallRet["d"]["SID"].ToString();
                R.Result = EWin.Lobby.enumResult.OK;
            }

        } catch (Exception) {
        }

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult CreateAccount(string GUID, string LoginAccount, string LoginPassword, string ParentPersonCode, string CurrencyList, EWin.Lobby.PropertySet[] PS,EWinOfficial.LobbyAPI.PropertySet[] PS2)
    {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult();
        R = lobbyAPI.CreateAccount(GetToken(), GUID, LoginAccount, LoginPassword, "", CurrencyList, PS);
        if (R.Result == EWin.Lobby.enumResult.OK)
        {
            EWinOfficial.LobbyAPI.LobbyAPI officiallobbyAPI = new EWinOfficial.LobbyAPI.LobbyAPI();
            string Token;
            int RValue;
            Random Ran = new Random();
            RValue = Ran.Next(100000, 9999999);
            Token = EWinWeb.CreateToken("fdb40b9c-1082-4541-8f08-0a696c00b4ce", "448S17685539176887", RValue.ToString());

            var R2 = officiallobbyAPI.CreateAccount(Token, GUID, LoginAccount, LoginPassword, ParentPersonCode, CurrencyList, PS2);

        }

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult CheckValidateCode(string GUID, EWin.Lobby.enumValidateType ValidateType, string EMail, string ContactPhonePrefix, string ContactPhoneNumber, string ValidateCode) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.CheckValidateCode(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber, ValidateCode);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SetUserMail(string GUID, EWin.Lobby.enumValidateType ValidateType, CodingControl.enumSendMailType SendMailType, string EMail, string ContactPhonePrefix, string ContactPhoneNumber, string ReceiveRegisterRewardURL)
    {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.ValidateCodeResult validateCodeResult;
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { GUID = GUID, Result = EWin.Lobby.enumResult.ERR };
        string ValidateCode = string.Empty;
        TelPhoneNormalize telPhoneNormalize = new TelPhoneNormalize(ContactPhonePrefix, ContactPhoneNumber);
        if (telPhoneNormalize != null)
        {
            ContactPhonePrefix = telPhoneNormalize.PhonePrefix;
            ContactPhoneNumber = telPhoneNormalize.PhoneNumber;
        }

        switch (SendMailType)
        {
            case CodingControl.enumSendMailType.Register:
                validateCodeResult = lobbyAPI.SetValidateCodeOnlyNumber(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber);
                if (validateCodeResult.Result == EWin.Lobby.enumResult.OK)
                {
                    ValidateCode = validateCodeResult.ValidateCode;
                }
                break;
            case CodingControl.enumSendMailType.ForgetPassword:
                validateCodeResult = lobbyAPI.SetValidateCodeOnlyNumber(GetToken(), GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber);
                if (validateCodeResult.Result == EWin.Lobby.enumResult.OK)
                {
                    ValidateCode = validateCodeResult.ValidateCode;
                }
                break;
            case CodingControl.enumSendMailType.ThanksLetter:

                break;
        }

        switch (ValidateType)
        {
            case EWin.Lobby.enumValidateType.EMail:
                if (SendMailType == CodingControl.enumSendMailType.RegisterReceiveReward)
                {
                    R = SendRegisterReceiveRewardMail(EMail, R, ReceiveRegisterRewardURL);
                }
                else
                {
                    R = SendMail(EMail, ValidateCode, R, SendMailType);
                }
                break;
            case EWin.Lobby.enumValidateType.PhoneNumber:
                string smsContent = "新規登録確認コード（" + ValidateCode + "）" + "\r\n" + "マハラジャをお選びいただき、ありがとうございます。";
                R = SendSMS(GUID, "0", 0, ContactPhonePrefix + ContactPhoneNumber, smsContent);
                break;
            default:
                break;
        }

        return R;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult SendSMS(string GUID, string SMSTypeCode, int RecvUserAccountID, string ContactNumber, string SendContent)
    {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        EWin.Lobby.APIResult R = new EWin.Lobby.APIResult() { GUID = GUID, Result = EWin.Lobby.enumResult.ERR };
        string ValidateCode = string.Empty;

        R = lobbyAPI.SendSMS(GetToken(), GUID, SMSTypeCode, RecvUserAccountID, ContactNumber, SendContent);

        return R;
    }

    private EWin.Lobby.APIResult SendMail(string EMail, string ValidateCode, EWin.Lobby.APIResult result, CodingControl.enumSendMailType SendMailType)
    {
        string Subject = string.Empty;
        string SendBody = string.Empty;
        string apiURL = "https://mail.surenotifyapi.com/v1/messages";
        string apiKey = "NDAyODgxNDM4MGJiZTViMjAxODBkYjZjMmRjYzA3NDgtMTY1NDE0Mzc1NC0x";
        Subject = "Verify Code";

        SendBody = CodingControl.GetEmailTemp(EMail, ValidateCode, SendMailType);

        try
        {
            Newtonsoft.Json.Linq.JObject objBody = new Newtonsoft.Json.Linq.JObject();
            Newtonsoft.Json.Linq.JObject objRecipients = new Newtonsoft.Json.Linq.JObject();
            Newtonsoft.Json.Linq.JArray aryRecipients = new Newtonsoft.Json.Linq.JArray();

            objBody.Add("subject", Subject);
            objBody.Add("fromName", "マハラジャ");
            objBody.Add("fromAddress", "edm@casino-maharaja.com");
            objBody.Add("content", SendBody);

            objRecipients.Add("name", EMail);
            objRecipients.Add("address", EMail);
            aryRecipients.Add(objRecipients);

            objBody.Add("recipients", aryRecipients);

            CodingControl.GetWebTextContent(apiURL, "POST", objBody.ToString(), "x-api-key:" + apiKey, "application/json", System.Text.Encoding.UTF8);
            result.Result = EWin.Lobby.enumResult.OK;
            result.Message = "";

        }
        catch (Exception ex)
        {
            result.Result = EWin.Lobby.enumResult.ERR;
            result.Message = "";
        }
        return result;
    }

    public string GetToken()
    {
        string Token;
        int RValue;
        Random R = new Random();
        RValue = R.Next(100000, 9999999);
        Token = EWinWeb.CreateToken(EWinWeb.PrivateKey, EWinWeb.APIKey, RValue.ToString());

        return Token;
    }

    private bool CheckPassword(string Hash)
    {
        string key = EWinWeb.PrivateKey;

        bool Ret = false;
        int index = Hash.IndexOf('_');
        string tempStr1 = Hash.Substring(0, index);
        string tempStr2 = Hash.Substring(index + 1);
        string checkHash = "";
        DateTime CreateTime;
        DateTime TargetTime;
        if (index > 0)
        {
            if (DateTime.TryParse(tempStr1, out CreateTime))
            {
                if (CreateTime.AddMinutes(15) >= DateTime.Now.AddSeconds(1))
                {
                    TargetTime = RoundUp(CreateTime, TimeSpan.FromMinutes(15));
                    checkHash = CodingControl.GetMD5(TargetTime.ToString("yyyy/MM/dd HH:mm:ss") + key, false).ToLower();
                    if (checkHash.ToLower() == tempStr2)
                    {
                        Ret = true;
                    }
                }
            }
        }

        return Ret;

    }

    private DateTime RoundUp(DateTime dt, TimeSpan d)
    {
        return new DateTime((dt.Ticks + d.Ticks - 1) / d.Ticks * d.Ticks, dt.Kind);
    }

    private void SetResultException(APIResult R, string Msg)
    {
        if (R != null)
        {
            R.Result = enumResult.ERR;
            R.Message = Msg;
        }
    }

    private EWin.Lobby.APIResult SendRegisterReceiveRewardMail(string EMail, EWin.Lobby.APIResult result, string ReceiveRegisterRewardURL)
    {
        string Subject = string.Empty;
        string SendBody = string.Empty;
        string apiURL = "https://mail.surenotifyapi.com/v1/messages";
        string apiKey = "NDAyODgxNDM4MGJiZTViMjAxODBkYjZjMmRjYzA3NDgtMTY1NDE0Mzc1NC0x";
        Subject = "RegisterReceiveReward";

        SendBody = CodingControl.GetRegisterReceiveRewardEmailTemp(EMail, ReceiveRegisterRewardURL);

        try
        {

            Newtonsoft.Json.Linq.JObject objBody = new Newtonsoft.Json.Linq.JObject();
            Newtonsoft.Json.Linq.JObject objRecipients = new Newtonsoft.Json.Linq.JObject();
            Newtonsoft.Json.Linq.JArray aryRecipients = new Newtonsoft.Json.Linq.JArray();

            objBody.Add("subject", Subject);
            objBody.Add("fromName", "マハラジャ");
            objBody.Add("fromAddress", "edm@casino-maharaja.com");
            objBody.Add("content", SendBody);

            objRecipients.Add("name", EMail);
            objRecipients.Add("address", EMail);
            aryRecipients.Add(objRecipients);

            objBody.Add("recipients", aryRecipients);

            CodingControl.GetWebTextContent(apiURL, "POST", objBody.ToString(), "x-api-key:" + apiKey, "application/json", System.Text.Encoding.UTF8);
            result.Result = EWin.Lobby.enumResult.OK;
            result.Message = "";

        }
        catch (Exception ex)
        {
            result.Result = EWin.Lobby.enumResult.ERR;
            result.Message = "";
        }
        return result;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public EWin.Lobby.APIResult CheckAccountExist(string GUID, string LoginAccount) {
        EWin.Lobby.LobbyAPI lobbyAPI = new EWin.Lobby.LobbyAPI();
        return lobbyAPI.CheckAccountExist(GetToken(), GUID, LoginAccount);
    }


    public class APIResult
    {
        public enumResult Result { get; set; }
        public string GUID { get; set; }
        public string Message { get; set; }
    }

    public enum enumResult
    {
        OK = 0,
        ERR = 1
    }

    public class PaymentValueReslut : APIResult
    {
        public string LoginAccount { get; set; }
        public string PaymentCode { get; set; }
        public string PaymentSerial { get; set; }
        public decimal Amount { get; set; }
        public decimal TotalPointValue { get; set; }
        public decimal TotalThresholdValue { get; set; }
        public List<string> ActivityDescription { get; set; }
        public string PaymentDescription { get; set; }
    }

    public class UserAccountSummaryResult : APIResult
    {
        public string SummaryGUID { get; set; }
        public DateTime SummaryDate { get; set; }
        public string LoginAccount { get; set; }
        public int DepositCount { get; set; }
        public decimal DepositRealAmount { get; set; }
        public decimal DepositAmount { get; set; }
        public int WithdrawalCount { get; set; }
        public decimal WithdrawalRealAmount { get; set; }
        public decimal WithdrawalAmount { get; set; }
    }

    public class UserAccountTotalSummaryResult : APIResult
    {
        public string LoginAccount { get; set; }
        public int DepositCount { get; set; }
        public decimal DepositRealAmount { get; set; }
        public decimal DepositAmount { get; set; }
        public int WithdrawalCount { get; set; }
        public decimal WithdrawalRealAmount { get; set; }
        public decimal WithdrawalAmount { get; set; }
        public DateTime LastDepositDate { get; set; }
        public DateTime LastWithdrawalDate { get; set; }
        public string FingerPrint { get; set; }
    }

    public class BulletinBoardResult : APIResult
    {
        public int BulletinBoardID { get; set; }
        public string BulletinTitle { get; set; }
        public string BulletinContent { get; set; }
        public DateTime CreateDate { get; set; }
        public int State { get; set; }

    }

    public class CompanyCategoryResult : APIResult
    {
        public int CompanyCategoryID { get; set; }
        public int CategoryType { get; set; }
        public string CategoryName { get; set; }
        public int SortIndex { get; set; }
        public int State { get; set; }
    }
}