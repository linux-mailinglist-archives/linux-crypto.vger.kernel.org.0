Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5614B173E
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Feb 2022 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbiBJUyN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Feb 2022 15:54:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbiBJUyN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Feb 2022 15:54:13 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F21090
        for <linux-crypto@vger.kernel.org>; Thu, 10 Feb 2022 12:54:13 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x15so10025954pfr.5
        for <linux-crypto@vger.kernel.org>; Thu, 10 Feb 2022 12:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RPcpsWOSoJqt+afmo823pwCXCLHnm9RTzBKNtko7Nsc=;
        b=HMM3LGOO+keL6aExHJb7PFb7qlZhQdl7aagRUxxQ6lQGXHdqVAVXvEIz+pL9csSMAc
         ThG4ssgusOS+CJxI0LeSaKpdJHOSgvXFoANQ4udAm0WYMgv5p8n89UNuD5/yW2GF9/P+
         j3yl4UOp1vGwnd4AxBWrcqCCxfUoUBPtgFZGi09ow6LnwewJCojpB5t3ESkE5dvWd9qd
         eIjgjJObCKinqFNIKDu/rg2PVNkpVlW6S2k7SxRczagmSAXnqz9PX25ikRKS72bQLrSX
         xIf3AA9eGrXW3OfM9jLg67aClTE3oEq58KMZ8nOjtj7tkZCzhN9ZKW4S8XKBSQ1CC8EB
         S94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RPcpsWOSoJqt+afmo823pwCXCLHnm9RTzBKNtko7Nsc=;
        b=fU5jLUIpThUKslxvAsOc+5csFJIBbtpiS5chXtuHWBkFUImQKnE2/qRNhxpSmN7sDq
         5daJIHrm1s/CL/efVY47tu4W26aHtEtUpAFlOY/tSX8nmIo+6DmcvSZYY1Awd4Wj/1by
         uvjh7ltXftU7cGkv7JD+ImlJiNIFKS1TTtTcFkkg5ZJXVyD7EDhGg0jWsFSnbJSI2qiD
         jJM9iz01RFf0TcOF+aMbFfSbSXO++qIKU6fd2VJeOz/wBYsLG5ydk3zoPkxbaoq0O23e
         +mBooADOojziDsq3f1qTweRsIAPa6ZuHIm3E973wTNJ5Ef1z+pSXL5tlA26sXhn+7Cdh
         TIKQ==
X-Gm-Message-State: AOAM5316Sr9UErKuOEu5POHPBDrkPspvrnq8R2YdSBYRnvozUOoKtrcq
        jFRmaKsRcy3QE/ptOiiBJmd34kAxOcQ4bDqg7ME=
X-Google-Smtp-Source: ABdhPJzo1fFCUR15KsFNAZ2dARccK2ohrA3DQcwIPfNu4QmbJLO7XSDE/S8/s98ZGiSOhduVfOSqUZAHOW4UrMwVTUI=
X-Received: by 2002:aa7:9acb:: with SMTP id x11mr9208781pfp.82.1644526453507;
 Thu, 10 Feb 2022 12:54:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:d6:b0:70:f80f:2357 with HTTP; Thu, 10 Feb 2022
 12:54:13 -0800 (PST)
Reply-To: tiffanywiffany@gmx.com
From:   Tiffany Wiffany <amijean41@gmail.com>
Date:   Thu, 10 Feb 2022 12:54:13 -0800
Message-ID: <CAF258RXei9CXNOiuPt4dUfpXrumeEt8S-+RSYMndnOGQOCAMug@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 

Hi, please with honest did you receive my message?
