Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2694486F8D
	for <lists+linux-crypto@lfdr.de>; Fri,  7 Jan 2022 02:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbiAGBRr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 6 Jan 2022 20:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbiAGBRr (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 6 Jan 2022 20:17:47 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A939FC061245
        for <linux-crypto@vger.kernel.org>; Thu,  6 Jan 2022 17:17:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so4580868wmk.1
        for <linux-crypto@vger.kernel.org>; Thu, 06 Jan 2022 17:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+dkiLt9yMO6x46qZW333QEXi70FYxlft58uImyv90V8=;
        b=hE7fdBYd19HQzQ9ujohzLkyrWDddKTJas5ByggfUnaJafVDn7oQyFLYyRFgpeVg1kf
         1/sECtFG5tSATH/yoHLrs5bhre7XkruD1FncGfxXEmzGT33z/dDWkET8rX4AXFRLtUqw
         UuctPIfdlZulTxJcqOaPaWW1exy+8mWprZYLRTPG9TWQemfCXDski7k5lATin1iQ5+lN
         WZi3n+pHmIA6y5GUIoWlmfsgnLyRbwVgyWNXkLZvksV2vcazM0drVb9KO8jNzgOsoFOm
         TNg+z0XwHuxfp6yPgUtQgPttLn1XCaFvl6aRGzoTD04Thu9SsoguC6f8B3yOh6rapiNc
         VO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=+dkiLt9yMO6x46qZW333QEXi70FYxlft58uImyv90V8=;
        b=M9KsiPs0Fb1oyyeEPRwWarLLEq0+dOOwBKLO+hBHyFJvX9qLDhcJO6X/z9PyDOyxtO
         85lIlfRWpZxrkuMAnuauSsLbzi2SHJ0qpYzyjKE2UYj25f7sg16erx/QhroSd4jcK/+v
         d/K63NXAtQNc9Hu3+xly9Y2RSDw4mqBJd/MOcdFDiLTMMxfMDEMsGzngxH44AbwSNFvC
         Rw4Zl4tE0GV/ik9kuexS55IqOtD+y0A5Z5gnQ94IPONI3hOaQP9n9bgy8BmwiZXwCSIO
         Isw02AlrzBzkbnYaqEOvoXd51eVqb2ez+y6A65VINo7TNter40VnsgGrcH5X7pQBvBXT
         ZCWQ==
X-Gm-Message-State: AOAM531CFWshVxPU2B+NLEIE3a0zOlOHNmBvFO+gR4N0P1/+TElQCqBm
        EdM4AoRe10eqjDbJ1SYqaWqJRaYmNW/MqQGgD0M=
X-Google-Smtp-Source: ABdhPJzaFmifdjV701bw8qLpSZo0QA6HifadV6luVPEGkhKReYmGQEMf8J0Sa/0QuPkqN0rGj/554Ad9/RNBLPglu6w=
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr3387230wmj.64.1641518265143;
 Thu, 06 Jan 2022 17:17:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:110c:0:0:0:0 with HTTP; Thu, 6 Jan 2022 17:17:44
 -0800 (PST)
Reply-To: mr.luisfernando5050@gmail.com
From:   "Mr. Luis Fernando" <kasimmohamed0099@gmail.com>
Date:   Thu, 6 Jan 2022 17:17:44 -0800
Message-ID: <CANUogzUBhLOoFn5vOKYjoKSL3Rx-Z-tn-FeXsCLA6ROiQCRAEQ@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

LS0gDQpJIGFtIE1yLmx1aXMgZmVybmFuZG8NCg0KSGkgRnJpZW5kIEkgd29yayBpbiBhIEJhbmsg
Zm9yIEFmcmljYSAoQk9BKSBoZXJlIGluIEJVUktJTkEgRkFTTw0KDQpJIHdhbnRzIHRvIHRyYW5z
ZmVyIGFuIGFiYW5kb25lZCBzdW0gb2YgMjcuNSBtaWxsaW9ucyBVU0QgdG8geW91DQp0aHJvdWdo
IEFUTSBWSVNBIENBUkQgLjUwJSB3aWxsIGJlIGZvciB5b3UuIE5vIHJpc2sgaW52b2x2ZWQuDQoN
Cg0KVGhlIChCT0EpIGJhbmsgd2FzIGJlaW5nIHVzZWQgYnkgbWFueSBBZnJpY2FuIFBvbGl0aWNp
YW5zIHRvIGRpdmVydA0KZnVuZHMgKHRoZSBQb2xpdGljaWFucyBsb290ZWQgb3ZlcjViaWxsaW9u
IFVuaXRlZCBTdGF0ZXMgZG9sbGFycykgdG8NCnRoZWlyIGZvcmVpZ24gYWNjb3VudHMgYW5kIHRo
ZXkgZGlkIE5vdCBib3RoZXIgdG8ga25vdyBob3cgbXVjaCB3YXMNCnRyYW5zZmVycmVkIGJlY2F1
c2UgdGhlIGZ1bmRzIGJlbG9uZ2VkIHRvIHRoZSAnU3RhdGUnIHRoYXQgaXMgd2h5IEkNCmFsc28g
ZGVjaWRlZCB0byBwdXQgYXBhcnQgdGhlIHN1bSBvZiAgJDI3LjVtaWxsaW9uIERvbGxhcnMgd2hp
Y2ggaXMNCnN0aWxsIGluIG91ciBiYW5rIHVuZGVyIG15IGN1c3RvZHkgZm9yIGEgbG9uZyBwZXJp
b2Qgbm93IQ0KDQpJIGhhdmUgdG8gZ2l2ZSB5b3UgYWxsIHRoZSByZXF1aXJlZCBndWlkZWxpbmVz
IHNvIHRoYXQgeW91IGRvIG5vdA0KbWFrZSBhbnkgbWlzdGFrZS4gSWYgeW91IGFyZSBjYXBhYmxl
IHRvIGhhbmRsZSB0aGUgdHJhbnNhY3Rpb24gQ29udGFjdA0KbWUgZm9yIG1vcmUgZGV0YWlscy4g
S2luZGx5IHJlcGx5IG1lIGJhY2sgdG8gbXkgYWx0ZXJuYXRpdmUgZW1haWwNCmFkZHJlc3MgKG1y
Lmx1aXNmZXJuYW5kbzUwNTBAZ21haWwuY29tKSBNci5sdWlzIEZlcm5hbmRvDQoNCg0KDQoNCg0K
DQrmiJHmmK/ot6/mmJPmlq/Ct+i0ueWwlOWNl+WkmuWFiOeUnw0KDQrll6jvvIzmnIvlj4vvvIzm
iJHlnKjluIPln7rnurPms5XntKLnmoTkuIDlrrbpnZ7mtLLpk7booYwgKEJPQSkg5bel5L2cDQoN
CuaIkeaDs+mAmui/hyBBVE0gVklTQSBDQVJEIOWwhuS4gOeslOW6n+W8g+eahCAyNzUwIOS4h+e+
juWFg+i9rOe7meaCqO+8jDAuNTAlIOWwhuaYr+e7meaCqOeahOOAgiDkuI3mtonlj4rpo47pmanj
gIINCg0KDQrorrjlpJrpnZ7mtLLmlL/lrqLliKnnlKggKEJPQSkg6ZO26KGM5bCG6LWE6YeR77yI
5pS/5a6i5o6g5aS65LqG6LaF6L+HIDUwDQrkur/nvo7lhYPvvInovaznp7vliLDku5bku6znmoTl
pJblm73otKbmiLfvvIzku5bku6zkuZ/mh5Llvpfnn6XpgZPovaznp7vkuoblpJrlsJHvvIzlm6Dk
uLrov5nkupvotYTph5HlsZ7kuo7igJzlm73lrrbigJ0NCuS4uuS7gOS5iOaIkei/mOWGs+WumuaK
iueOsOWcqOmVv+acn+S/neeuoeWcqOaIkeS7rOmTtuihjOeahDI3NTDkuIfnvo7lhYPliIblvIDv
vIENCg0KICDmiJHlv4Xpobvnu5nkvaDmiYDmnInlv4XopoHnmoTmjIflr7zmlrnpkojvvIzov5nm
oLfkvaDlsLHkuI3kvJrniq/ku7vkvZXplJnor6/jgIIg5aaC5p6c5oKo5pyJ6IO95Yqb5aSE55CG
5Lqk5piT77yM6K+36IGU57O75oiR5LqG6Kej5pu05aSa6K+m5oOF44CCIOivt+WbnuWkjeaIkeea
hOWkh+eUqOeUteWtkOmCruS7tuWcsOWdgA0KKG1yLmx1aXNmZXJuYW5kbzUwNTBAZ21haWwuY29t
KSBNci5sdWlzIEZlcm5hbmRvDQo=
