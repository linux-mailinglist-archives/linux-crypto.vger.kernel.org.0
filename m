Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE86F5802
	for <lists+linux-crypto@lfdr.de>; Wed,  3 May 2023 14:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjECMe4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 May 2023 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjECMez (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 May 2023 08:34:55 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E91A49CD
        for <linux-crypto@vger.kernel.org>; Wed,  3 May 2023 05:34:52 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-32a249b416fso40740455ab.1
        for <linux-crypto@vger.kernel.org>; Wed, 03 May 2023 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683117291; x=1685709291;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HNHYwnLEvnLgSMzznBh/gGVID9t8HFwI7dBcOQwExQ=;
        b=hiEZlbuOI1SysK4yUcS6UrhgbN2Ni6BlqSH+MycJ2aPGDfY+EeOGnGmbAw7SgPU/df
         NSp8UxJlglAeP0Ph5foU+08siq40PMvRYD2beT3Z/kuSO2Jcg6frnRa8saHsviqpCSyC
         iRQftc4PQom0WAqoeDF7saFAIf4fiTU1Kj6w0gLTneSgXK9S//zqEWHQ49SwWXHkg5N7
         9ih6ghzE3sIzu3X2gYJrGmhh12cjMol9UIjq2RV5zhrbBoalg3j0YyV3Z91QTILZz/Xq
         jkCSEOCuF9kipwezPZ4idAnyPHyprsOyxolNANZqY7Gt2Pqu7C3uWNp8Py0a2UxIJ69t
         faBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683117291; x=1685709291;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HNHYwnLEvnLgSMzznBh/gGVID9t8HFwI7dBcOQwExQ=;
        b=USL9GU2KnShNTh7qwcBSKQxAXPSqmHLpBOda+hEkI0sqLrnHjgdsQRRxazkTN73oSv
         0PgMMIX2CtkU7nFVyTdXvXY4tjV3O1f2x4aX1b1HNDQjtCylqm/ZfNeAAXtG5Lc5R5gO
         MaSCAFd5nrkwrrhB9VaO9iHmrt1WJQ2I7BNEdRFPoIAhUNFSZV2fNGfvh91K5y7ABOsq
         QygFjDwu2ejJr6kyZWF/aafQ6Dfiv093JVZQLbvTDUl3XBQjl9UEbZw0qRk1A0wiWqoi
         IefrM7/5hfhs2nxGBUDHgnBHS1WzuFQ5EZ7eKlEWEZe7OrwKO9/dn7ZDNE42v6H5bV5h
         vkjw==
X-Gm-Message-State: AC+VfDyhYTZazQojeKyxUUS2TsmmViuxcHgJRec4wgPtBkLdcJu7esCk
        u1/UFNEVCt7Ny3lJgWhyY2HVjIDSe3HarT7BElM=
X-Google-Smtp-Source: ACHHUZ6mmO8v0BOkCbLAjMVgRyjf4t+2ANzH0i9Q/ZMgvuJG34EtR37SVlMt/ib4hohvNPi1LY5cIF91HSQCsEGa8pg=
X-Received: by 2002:a92:3205:0:b0:331:96b:2162 with SMTP id
 z5-20020a923205000000b00331096b2162mr5098959ile.13.1683117291152; Wed, 03 May
 2023 05:34:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:1301:b0:40a:f22a:44ce with HTTP; Wed, 3 May 2023
 05:34:50 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <revsistergracewilliams02@gmail.com>
Date:   Wed, 3 May 2023 13:34:50 +0100
Message-ID: <CALq9C432wiKLAkg9Jwv9cQ1RTFtPeE9y2KOQYa2SO2pa1hw-Zw@mail.gmail.com>
Subject: Partnership
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greeting. please i want to know if you're ready for business investment
project in
your country because i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email below.

Thanks and awaiting for your quick response,

Amos!
