Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023E648231
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Dec 2022 13:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLIMLI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Dec 2022 07:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLIMK4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Dec 2022 07:10:56 -0500
X-Greylist: delayed 152 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 04:10:53 PST
Received: from egvmx03.erzbistum-koeln.de (egvmx03.erzbistum-koeln.de [62.225.58.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516C44386B
        for <linux-crypto@vger.kernel.org>; Fri,  9 Dec 2022 04:10:52 -0800 (PST)
Received: from [10.237.170.112] (port=61774 helo=EGVEX02.ad.erzbistum-koeln.de)
        by egvmx03.erzbistum-koeln.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <torsten.hohmann@erzbistum-koeln.de>)
        id 1p3c5o-0001Zz-L3; Fri, 09 Dec 2022 13:03:04 +0100
Received: from EGVEX02.ad.erzbistum-koeln.de (10.237.170.112) by
 EGVEX02.ad.erzbistum-koeln.de (10.237.170.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 13:02:58 +0100
Received: from EGVEX02.ad.erzbistum-koeln.de ([fe80::4c7d:76a3:f25f:c234]) by
 EGVEX02.ad.erzbistum-koeln.de ([fe80::4c7d:76a3:f25f:c234%7]) with mapi id
 15.01.2507.016; Fri, 9 Dec 2022 13:02:58 +0100
From:   <torsten.hohmann@erzbistum-koeln.de>
Subject: 
Thread-Index: AQHZC8YtPbaZz5NBe0iKQRWo7N2v7A==
Date:   Fri, 9 Dec 2022 12:02:58 +0000
Message-ID: <d5668c70-9b4f-0d23-6975-a0c8edff845a@erzbistum-koeln.de>
Reply-To: <hansjorgw3@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
x-originating-ip: [10.237.173.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <658534328A56544E8C98FDB6085601E7@Erzbistum-Koeln.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Sophos-OBS: success
X-SASI-Version: Antispam-Engine: 5.1.1, AntispamData: 2022.12.9.113317
X-SASI-RCODE: 200
X-SASI-SpamProbability: 12%
X-SASI-Hits: BLANK_SUBJECT 0.100000, BODYTEXTP_SIZE_3000_LESS 0.000000,
 BODY_SIZE_1000_LESS 0.000000, BODY_SIZE_2000_LESS 0.000000,
 BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
 BODY_SIZE_800_899 0.000000, CTE_BASE64 0.000000,
 FRAUD_WEBMAIL_R_NOT_F 0.100000, HDR_COMMON_LOWERCASE 0.000000,
 HTML_00_01 0.050000, HTML_00_10 0.050000, MISSING_HEADERS 0.000000,
 MSGID_SAMEAS_FROM_HEX_844412 0.100000, NO_FUR_HEADER 0.000000,
 NO_REAL_NAME 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
 REPLYTO_FROM_DIFF_ADDY 0.100000, SENDER_NO_AUTH 0.000000,
 SINGLE_URI_IN_BODY 0.000000, SUPERLONG_LINE 0.050000, TO_MALFORMED 0.000000,
 URI_WITH_PATH_ONLY 0.000000, WEBMAIL_REPLYTO_NOT_FROM 0.500000,
 WEBMAIL_SOURCE 0.000000, WEBMAIL_XOIP 0.000000, WEBMAIL_X_IP_HDR 0.000000,
 __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
 __BODY_STARTS_WITH_2XDASH 0.000000, __BULK_NEGATE 0.000000,
 __CP_URI_IN_BODY 0.000000, __CT 0.000000, __CTE 0.000000,
 __CT_TEXT_PLAIN 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
 __DQ_NEG_IP 0.000000, __FRAUD_BODY_WEBMAIL 0.000000, __FRAUD_MONEY 0.000000,
 __FRAUD_MONEY_CURRENCY 0.000000, __FRAUD_MONEY_CURRENCY_EURO 0.000000,
 __FRAUD_MONEY_DENOMINATION 0.000000, __FRAUD_MONEY_VALUE 0.000000,
 __FRAUD_WEBMAIL 0.000000, __FRAUD_WEBMAIL_REPLYTO 0.000000,
 __FROM_DOMAIN_NOT_IN_BODY 0.000000, __FROM_NAME_NOT_IN_ADDR 0.000000,
 __FROM_NAME_NOT_IN_BODY 0.000000, __FROM_NO_NAME 0.000000,
 __FUR_RDNS_SOPHOS 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
 __HAS_REPLYTO 0.000000, __HAS_XOIP 0.000000, __HIGHBITS 0.000000,
 __HTTPS_URI 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
 __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MOZILLA_USER_AGENT 0.000000, __MSGID_HEX_844412 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
 __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
 __PHISH_SPEAR_STRUCTURE_2 0.000000, __RCVD_FROM_DOMAIN 0.000000,
 __REPLYTO_GMAIL 0.000000, __REPLYTO_SAMEAS_FROM_NAME 0.000000,
 __SANE_MSGID 0.000000, __SINGLE_URI_TEXT 0.000000, __URI_IN_BODY 0.000000,
 __URI_MAILTO 0.000000, __URI_NOT_IMG 0.000000, __URI_NO_WWW 0.000000,
 __URI_NS 0.000000, __URI_WITH_PATH 0.000000, __USER_AGENT 0.000000
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,
        MISSING_HEADERS,MONEY_FREEMAIL_REPTO,REPLYTO_WITHOUT_TO_CC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hansjorgw3[at]gmail.com]
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

DQotLSANCkhhbGxvLA0KDQpJY2ggYmluIEhlcnIgSGFuc2rDtnJnIFd5c3MsIGVpbiBTY2h3ZWl6
ZXIgR2VzY2jDpGZ0c21hbm4sIGVoZW1hbGlnZXIgQ0VPLCBWb3JzaXR6ZW5kZXIgdm9uIFN5bnRo
ZXMsIFd5c3MgRm91bmRhdGlvbi4gMjUgUHJvemVudCBtZWluZXMgcGVyc8O2bmxpY2hlbiBWZXJt
w7ZnZW5zIHdlcmRlbiBmw7xyIHdvaGx0w6R0aWdlIFp3ZWNrZSBhdXNnZWdlYmVuLiBVbmQgaWNo
IGhhYmUgYXVjaCB2ZXJzcHJvY2hlbiwgaW4gZGllc2VtIEphaHIgMjAyMiBtZWhyIGFuIEVpbnpl
bHBlcnNvbmVuIHp1IGdlYmVuLiBJY2ggaGFiZSBtaWNoIGVudHNjaGllZGVuLCAxLjcwMC4wMDAs
MDAgRXVybyBhbiBTaWUgenUgc3BlbmRlbi4gV2VubiBTaWUgYW4gbWVpbmVyIFNwZW5kZSBpbnRl
cmVzc2llcnQgc2luZCwgd2VuZGVuIFNpZSBzaWNoIGbDvHIgd2VpdGVyZSBJbmZvcm1hdGlvbmVu
IGFuOiBoYW5zam9yZ3czQGdtYWlsLmNvbQ0KVW50ZXIgZm9sZ2VuZGVtIExpbmsga8O2bm5lbiBT
aWUgYXVjaCBtZWhyIMO8YmVyIG1pY2ggZXJmYWhyZW4NCg0KaHR0cHM6Ly9lbi53aWtpcGVkaWEu
b3JnL3dpa2kvSGFuc2olQzMlQjZyZ19XeXNzDQoNCkdyw7zDn2UNCkhhbnNqw7ZyZyBXeXNzDQoN
Cg==
