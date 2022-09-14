var LobbyAPI = function (APIUrl) {
    this.KeepSID = function (SID, GUID, cb) {
        var url = APIUrl + "/KeepSID";
        var postData;

        postData = {
            SID: SID,
            GUID: GUID
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    this.GetFreeUserAccount = function (GUID, cb) {
        var url = APIUrl + "/GetFreeUserAccount";
        var postData;

        postData = {
            GUID: GUID
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    this.DepositUserAccountPoint = function (GUID, SID, cb) {
        var url = APIUrl + "/DepositUserAccountPoint";
        var postData;

        postData = {
            SID: SID,
            GUID: GUID
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    this.CheckAccountExist = function (GUID, LoginAccount, cb) {
        var url = APIUrl + "/CheckAccountExist";
        var postData;

        postData = {
            LoginAccount: LoginAccount,
            GUID: GUID
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    this.GetUserInfo = function (WebSID, GUID, cb) {
        var url = APIUrl + "/GetUserInfo";
        var postData;

        postData = {
            WebSID: WebSID,
            GUID: GUID
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    this.CreateAccount = function (GUID, LoginAccount, LoginPassword, ParentPersonCode, CurrencyList, PS, cb) {
        var url = APIUrl + "/CreateAccount";
        var postData;

        postData = {
            GUID: GUID,
            LoginAccount: LoginAccount,
            LoginPassword: LoginPassword,
            ParentPersonCode: ParentPersonCode,
            CurrencyList: CurrencyList,
            PS: PS,
            PS2: PS
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    this.SetUserMail = function (GUID, ValidateType, SendMailType, EMail, ContactPhonePrefix, ContactPhoneNumber, ReceiveRegisterRewardURL, cb) {
        var url = APIUrl + "/SetUserMail";
        var postData;

        postData = {
            GUID: GUID,
            ValidateType: ValidateType,
            SendMailType: SendMailType,
            EMail: EMail,
            ContactPhonePrefix: ContactPhonePrefix,
            ContactPhoneNumber: ContactPhoneNumber,
            ReceiveRegisterRewardURL: ReceiveRegisterRewardURL
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    this.CheckValidateCode = function (GUID, ValidateType, EMail, ContactPhonePrefix, ContactPhoneNumber, ValidateCode, cb) {
        var url = APIUrl + "/CheckValidateCode";
        var postData;

        postData = {
            GUID: GUID,
            ValidateType: ValidateType,
            EMail: EMail,
            ContactPhonePrefix: ContactPhonePrefix,
            ContactPhoneNumber: ContactPhoneNumber,
            ValidateCode: ValidateCode,
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    this.GetCompanySite = function (GUID, cb) {
        var url = APIUrl + "/GetCompanySite";
        var postData;

        postData = {
            GUID: GUID
        };

        callService(url, postData, 10000, function (success, text) {
            if (success == true) {
                var obj = getJSON(text);

                if (cb)
                    cb(true, obj);
            } else {
                if (cb)
                    cb(false, text);
            }
        });
    };

    function callService(URL, postObject, timeoutMS, cb) {
        var xmlHttp = new XMLHttpRequest;
        var postData;

        if (postObject)
            postData = JSON.stringify(postObject);

        xmlHttp.open("POST", URL, true);
        xmlHttp.onreadystatechange = function () {
            if (this.readyState == 4) {
                var contentText = this.responseText;

                if (this.status == "200") {
                    if (cb) {
                        cb(true, contentText);
                    }
                } else {
                    cb(false, contentText);
                }
            }
        };

        xmlHttp.timeout = timeoutMS;
        xmlHttp.ontimeout = function () {
            /*
            timeoutTryCount += 1;

            if (timeoutTryCount < 2)
                xmlHttp.send(postData);
            else*/
            if (cb)
                cb(false, "Timeout");
        };

        xmlHttp.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        xmlHttp.send(postData);
    }

    function getJSON(text) {
        var obj = JSON.parse(text);

        if (obj) {
            if (obj.hasOwnProperty('d')) {
                return obj.d;
            } else {
                return obj;
            }
        }
    }
}