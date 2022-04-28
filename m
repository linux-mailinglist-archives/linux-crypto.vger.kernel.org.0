Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C5D513CFB
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Apr 2022 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351981AbiD1VDd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 Apr 2022 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351979AbiD1VDd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 Apr 2022 17:03:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112B33EBC
        for <linux-crypto@vger.kernel.org>; Thu, 28 Apr 2022 14:00:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g6so11931189ejw.1
        for <linux-crypto@vger.kernel.org>; Thu, 28 Apr 2022 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=UIbSwXETQo8py8NKWWoOzTbdb19k4UaVxjqlebXhaiE=;
        b=YIW6hvy4E9AO2RG7jNSiPXUtArPCZkLu0e95qaAirJcph4Lzf4b/M/V8mtM1TuCf9u
         zU/su830r1YOELbE+uLyQH9w44+t79XoGR7jZwcU+DFkJS87M/VWdsAaoRc4lByilPDm
         4ic57sa3WCYK6GUt+cuxtv3nfAbigLs/9qOUl8iAbLo4+gCojaJeqB4/rVPfTbXoSlnz
         6442NfMromgRp/zcZ1401KXgh+U1LuVtTt/yKUrSpUEM2b/z6y1pRyngEHdgGj7oYp45
         llNN40ru31qanqtLOy/VKBybYw34fCh/xgHgLTJ7apAlSIexBYPdD4knMjt41tN6st78
         Wg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=UIbSwXETQo8py8NKWWoOzTbdb19k4UaVxjqlebXhaiE=;
        b=FjU4P7roJzB3MJYugyn3pHRx18ArWfcJXg7XSz54r8Fz4bgarvZsciY4bvRbIT9js5
         EaIrcAmGEtPKCrVz6Fs1bnneACQ9+lAAInSyEAr5vHDSDEJamblvfZGy54EXiCYsIfRC
         BqN6YuYISwYhrzgwQVgkGbRgVzGuo5+Mzm3gl7wXjc/NhFA066l7gLitSNd//mwgAeI6
         NF4rg2BCA/VQaLDAM86+EIZQA6jSZnnD6ZRvrhtW1KNXk5NsNRUD8m8vx7go5hQX94Ui
         KYKALF/vYiBBBPqKLkWbF/jWi5e9acWMLJrtt79Nxn279icNDjyYgpG59FXF3AA+H5Pk
         4IWw==
X-Gm-Message-State: AOAM530dIhdzRHR6RYBHczAvGN6V2qMIB19ONn/G1WY6Ob2jaBiXPzi0
        OSB5nUB3w7jQy4KQoVuVJQlGfo9az5QYsiEvt2M=
X-Google-Smtp-Source: ABdhPJyBgNAU+0WXzYIe3je3JHNZsgTvdzt1hUkZkBHqpEjC6SyEJKtPFNwv3xQ+WOm040kYXBSTtKpkq1HjSXYCp/U=
X-Received: by 2002:a17:906:7307:b0:6da:92e1:9c83 with SMTP id
 di7-20020a170906730700b006da92e19c83mr33432377ejc.459.1651179615981; Thu, 28
 Apr 2022 14:00:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:8759:0:0:0:0:0 with HTTP; Thu, 28 Apr 2022 14:00:14
 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <fionahill578@gmail.com>
Date:   Thu, 28 Apr 2022 14:00:14 -0700
Message-ID: <CAFw126F7GqeioiMQ-uYTWSO1uuYtZvzqC1iEJqJhwN6Ry033QQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Hello, did you receive my message i sent to you ?
