Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D663957EF
	for <lists+linux-crypto@lfdr.de>; Mon, 31 May 2021 11:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhEaJSc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 31 May 2021 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhEaJSb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 31 May 2021 05:18:31 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBA0C061574
        for <linux-crypto@vger.kernel.org>; Mon, 31 May 2021 02:16:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id o8so14208073ljp.0
        for <linux-crypto@vger.kernel.org>; Mon, 31 May 2021 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0FXlj/QQXTkbxZ5+G1nqRa4wr5u/BSR73Cf8Ct+Irq8=;
        b=hy/FdvtKh9WQITKj94VWB0NuPHdERaeWcKbAvQGL0khGpsdkDUf3y2iprzbwbjjtXT
         Vqp3Jc4OAxxS79VaoDx4DxkmknkTzbTCwOp9JTHHpmvNINHRcf3CZSU8KtroFMqM/HFL
         pGY2yZBsaIU3iyt7t2B0ILw6+gj1FP3haeuch/WSCcN6SxRmLKzJ05KeU1YFRRNC/2Fx
         c4qcJ76p1qj8YeidOP26hxeZPeDzXy1apfPbdJrb23RwxcOv5K4dF8ks6VXopdymU4UO
         YvSUAJMn5FsIErpkG4/FtsQbZnhWeaNm/6Iz/WqLbxkEnq4Vd90DIIrvkfCkHlmrohh/
         EbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=0FXlj/QQXTkbxZ5+G1nqRa4wr5u/BSR73Cf8Ct+Irq8=;
        b=kKVC95DXF1D6rl7Y+phpaxD2BNxxYlI2NgRsjds+bBu/eUaZXzl+HsdtmD0jMD7jl+
         Z3Hzyq1S+UafUkk7voDr5BN6hTGpZ8MhVQnyvVbMjwB8zz/IOuxZ7cHkrA3iwLpvr48W
         Pl+k4SkESB0TpDmNwySgwJFXfLcwsLO1U4lvsJ/LVtTuVprZfHDFqEceVGK+GAFAFX4c
         C/ZEDjcaa4ZyVYfXbddISb61/qKVaZI0GOsp5pl/OM/KgOXH+nUPu1VvzzRVAuMMuISk
         nf+nCl10c/KyhgouRMxwEJYauY4C+31PrKZtBsj+yVAwkQBwSY7IJfLh+1dMhtsWwFlh
         IHEg==
X-Gm-Message-State: AOAM532GjA2xycxPtOryAPalnB8zk6Rnl8fzgNjmoR5crL5LlQLzPjJb
        C64XQ2F63XA1am2Y5Pwm+0+JSYHjgSOIctmEd/8=
X-Google-Smtp-Source: ABdhPJwt/IHm+9lAvS4dG6QgPDMnX+HwrePW6sc3eDgg+Q60Fz3s8p7YvSZlq2ibiVX8lbEggSM/mu/rCJAjvBEkuqI=
X-Received: by 2002:a2e:2f03:: with SMTP id v3mr15704210ljv.168.1622452610373;
 Mon, 31 May 2021 02:16:50 -0700 (PDT)
MIME-Version: 1.0
Reply-To: yoshikoazumi9@gmail.com
Sender: jacksmith6012@gmail.com
Received: by 2002:ab3:7582:0:0:0:0:0 with HTTP; Mon, 31 May 2021 02:16:49
 -0700 (PDT)
From:   yoshiko Azumi <yoshikoazumi09@gmail.com>
Date:   Mon, 31 May 2021 12:16:49 +0300
X-Google-Sender-Auth: cktrLk8K7PJGHweieOs-tlcJo20
Message-ID: <CAOXLc2v8d3E5x_iBwssbv_eFPnqUeZR69v+GTgJ_RtwuZ7GLYw@mail.gmail.com>
Subject: =?UTF-8?B?5L2g5aW9?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

5Lul5oiR5Lus5YWo6IO955qE5LiK5bid55qE5ZCN5LmJ5ZCR5oKo6Zeu5aW977yM5aaC5p6c5oiR
55qE55S15a2Q6YKu5Lu25LiN56ym5ZCI5oKo55qE5ZWG5Lia5oiW5Liq5Lq66YGT5b6377yM6K+3
5o6l5Y+X5oiR6K+a5oya55qE6YGT5q2J44CC5oiR55yf55qE5b6I5oOz5LiO5oKo5bu656uL6Imv
5aW955qE5YWz57O777yM6ICM5LiU55Sx5LqO5oiR5Zyo6L+Z6YeM55qE57Sn5oCl5oOF5Ya177yM
5oiR5Yaz5a6a5LiO5oKo6IGU57O75piv5pyJ54m55q6K5Y6f5Zug55qE44CCDQrmiJHmmK/lronk
vY/nvo7lrZDlpKvkurrjgILmiJHmnaXoh6rml6XmnKzvvIzmiJHkuI7lm73pmYXmiL/lnLDkuqfn
rqHnkIbnu4/nuqrkurpBbGV4YW5kcmENClNtaXRo57uT5ama5bey5pyJMTHlubTvvIzkvYbku5bk
uo4yMDE45bm05q275LqO6Ie05ZG95Lqk6YCa5LqL5pWF44CC5oiR5Lus57uT5ama5bey5pyJMjDl
ubTvvIzmsqHmnInku7vkvZXlranlrZDjgIINCg0K5oiR5piv5Liq5a2k5YS/44CC5oiR5LiI5aSr
5Y675LiW5ZCO77yM5oiR5Yaz5a6a5LiN5YaN57uT5ama77yM5Zug5Li65oiR5Lus5piv55yf5q2j
55qE5aW95Z+6552j5b6S77yM5oiR5Lus55u45L+h5YWo6IO955qE5LiK5bid44CCDQrmiJHmgqPm
nInkubPohbrnmYzlkozllonnmYzvvIzlj6/ku6Xogq/lrprnmoTmmK/vvIzmiJHml6Dms5Xlt6Xk
vZzmiJblgZrku7vkvZXmnInljovlipvnmoTkuovmg4XjgILmiJHnmoTljLvnlJ/or7TmiJHmtLvk
uI3kuIvljrvkuobvvIzmjqXkuIvmnaXnmoQgMg0K5Liq5pyI6YO95rS75LiN5LiL5Y675LqG44CC
6L+Z5piv5Zug5Li65oiR55qE55mM55eH55eF5pivNOe6p++8jOWug+W3sue7j+iUk+W7tuWIsOaI
keeahOWFqOi6q+ezu+e7n++8jOWvueaIkeeahOi6q+S9k+WZqOWumOmAoOaIkOS6huW+iOWkmuS4
pemHjeeahOS8pOWus+OAgg0KDQrlnKjmiJHkuIjlpKvljrvkuJbkuYvliY3jgILku5bljZbmjonk
uobmiJHku6zmiYDmnInnmoTlm73pmYXotKLkuqfvvIzlsIYgMzMwIOS4h+e+juWFg++8iDMwMCDk
uIfvvIwzMA0K5LiH576O5YWD77yJ5a2Y5YWl5LqG5oiR576O5Zu95YWs5rCR55qE6ZO26KGM6LSm
5oi344CC5oiR5bey5pWF5LiI5aSr55qE5YWE5byf6YCD6LeR5LqG77yIMTAwIOS4h+e+juWFg++8
ieOAgg0K5oqK5oiR55WZ5Zyo5Yqg5ou/5aSn5Yy76Zmi562J5q2777yM5oiR6YCJ5oup6L+Z6L6I
5a2Q5LiN5YaN5ZKM5oiR5bey5pWF55qE5LiI5aSr5YWE5byf5YGa5Lu75L2V5LqL77yM5Zug5Li6
5LuW5LiN5Zyo5LmO5oiR77yM5Y+q5biM5pyb5oiR5q2744CCDQoNCuWtmOWFpei/meeslOmSse+8
iDMuMzAwLjAwMC4wMA0K576O5YWD77yJ55qE6ZO26KGM5ZCR5oiR5L+d6K+B77yM6L+Z56yU6ZKx
5bCG6L2s5YWl5oiR6YCJ5oup5bm25om55YeG55qE5Lu75L2V5Lq655qE6ZO26KGM6LSm5oi344CC
5oiR5q2j5Zyo5L2/55So5q2j5Zyo5o6l5Y+X55mM55eH5rK755aX55qE5Yy76Zmi6K6h566X5py6
5ZCR5oKo5Y+R6YCB5q2k5raI5oGv44CC5aaC5p6c5oiR5pS25Yiw5L2g55qE5b+r6YCf5Zue5aSN
77yM5oiR5Lya57uZ5L2g6ZO26KGM55qE6IGU57O75L+h5oGv5ZKM5aaC5L2V6IGU57O76ZO26KGM
55qE6K+05piO77yM5oiR6L+Y5Lya57uZ5L2g5Ye65YW35LiA5Lu95o6I5p2D5Lmm77yM6K+B5piO
5L2g5piv6L+Z56yU6ZKx55qE5Y6f5aeL5Y+X55uK5Lq644CCDQoNCuaIkeimgeS9oOaUtuWIsO+8
iDMuMzAwLjAwMC4wMCDnvo7lhYPvvInnmoTotYTph5HvvIzlrp7njrDmiJHmrbvliY3nmoTmnIDl
kI7kuIDkuKrmhL/mnJvjgILlnKjlpKnloILpgYfop4HmiJHnmoTkuIrluJ3jgILmiJHluIzmnJvk
vaDmiorov5nnrJTpkrHnmoQgNjAlDQrmjZDnu5nlraTlhL/jgIHmsqHmnInmr43kurLnmoTlranl
rZDjgIHmsqHmnInnibnmnYPnmoTlranlrZDjgILmi780MCXnmoTpkrHlgZrnlJ/mhI/vvIznhafp
ob7lrrbkurrlsLHmmK/kvaDnmoTnpo/liKnjgILmiJHlnKjov5nkuKrkuJbnlYzkuIrlj6rliank
uIvkuKTkuKrmnIjnmoTml7bpl7TkuobvvIzmiJHpnIDopoHnmoTmmK/kuIDkuKrlloToia/lloTo
ia/nmoTkurrvvIzog73mlLbliLDov5nnrJTpkrHvvIzlrozmiJDmiJHmrbvliY3nmoTmnIDlkI7k
uIDkuKrmhL/mnJvjgILor7fliqrlipvlsIbov5nnrJTpkrHnmoQNCjYwJSDnlKjkuo7mhYjlloTn
u4Tnu4fvvIzmjZDotaDnu5nlraTlhL/lkozlvLHlir/nvqTkvZPvvIzlubblsIYgNDAlIOeahOmS
seeUqOS6juiHquW3sQ0KDQrmiJHlj6rpnIDopoHkvaDkuIDkuKroh6rkv6HnmoTmib/or7rvvIzl
vZPov5nnrJTpkrHovazlhaXkvaDnmoTpk7booYzotKbmiLfml7bvvIzkvaDkvJrmjInnhafmiJHn
moTmjIfnpLrkvb/nlKjlroPjgILmiJHkuI3nm7jkv6HkurrvvIzkvYbmiJHlnKjlkJHmgqjlj5Hp
gIHmraTmtojmga/kuYvliY3npYjnpbfvvIzmiJHnmoTnsr7npZ7mjqXlj5fmgqjvvIzmiJHluIzm
nJvmgqjlp4vnu4jkuLrmiJHnpYjnpbfvvIzor7fpmo/ml7bkuI7miJHlkIjkvZzlpoLmnpzlm57l
pI3mnInlu7bov5/lsIbkuLrkuKrkurrmiJbnu4Tnu4fph4fotK3nlZnlh7rnqbrpl7Tlh7rkuo7l
kIzmoLfnmoTnm67nmoTjgIINCuivt+WQkeaIkeS/neivgeaCqOS8muaOpeWPl+aIkeeahOaKpeS7
t++8jOato+WmguaIkeWcqOi/memHjOaJgOivtOeahOmCo+agt++8jOaCqOeahOWbnuWkjeWwhuS4
jeiDnOaEn+a/gA0K
