Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4985D64457D
	for <lists+linux-crypto@lfdr.de>; Tue,  6 Dec 2022 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiLFOVK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 6 Dec 2022 09:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiLFOU5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 6 Dec 2022 09:20:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25C2DA93
        for <linux-crypto@vger.kernel.org>; Tue,  6 Dec 2022 06:20:57 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c66so14181326edf.5
        for <linux-crypto@vger.kernel.org>; Tue, 06 Dec 2022 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=UMQuNG/hsmEQ4ehAxyFfV1fe/IuuT2UQ3/WgWb0a1csSPsvCA3S7niqW1YcdmJjapg
         nH+wvWsnK7SF8cN0OnBo01bnKhSCXpr8ZYTp3wb/k8Jn2Q65AoqAmrllz9RGDng63LOB
         NybftSpKOQCxcmAYfFtfpCxju4jSrJTpxQY13Vhnvdny4jN1SnzcpRmsj3t13le1aAS7
         clcTkX8y/C8liuOn31Uo+HbNOXI8xBFQR6/B9Q0jmqlWkYIyXvrbHB4y+fwzs6jk6nd4
         v0HJhsoaUeMWHr+QaOWhFuQY0JWqQj2izwQQJn/STOUxVXi5jfaTIL3Q6kIxVIXBO04j
         hJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=Hok2KCa1WJDk5ArUYtfupi9uywKr1JUqpb3MPXoHRP17c65Dkr/atTc4LDzmlwFnkw
         xsM7SXi+afsd1/vmIVmKCB+m8hw3iSSNJfKUZ7TugLZXfrOM64jDcswnPI8a5OIsJMz/
         7tlTppAOPPVAi8NHJKRNvAS5ZOjm8w+QavvCWPCZPRxOryoZXyp0R0NPvX1ziJte0+Og
         rGQx0ZD8Khj8uxn+dvLlXlCfOfZmxMTVHCdtAPC1XolFsVDXmGeyOodiBJ6KtKZXCqH0
         ho+OIE3wf+U9tzGDGPOlCyoumXu8mnz4SPO6FaAdwnQFnEbLKKH87vdvKgrEHiopLe9Q
         h2AQ==
X-Gm-Message-State: ANoB5plMHMX8+OXXobnj8JVUFeORgyNPGuIrm6ltNf6VINxIUGXzzcz6
        KW0uMT1PzRGL2BcqRv3eld/TLYh+CDqOyIZP7vE=
X-Google-Smtp-Source: AA0mqf5l1RO+xonuyXisJSDMG2JyNTWiGD378XozzhYa5eT52tHsaSSJdPKcHP0IGSQ+dyYLxvZbP5cun0jmTOE42aU=
X-Received: by 2002:a05:6402:361:b0:46c:25ea:731 with SMTP id
 s1-20020a056402036100b0046c25ea0731mr16813909edw.194.1670336455465; Tue, 06
 Dec 2022 06:20:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6408:159f:b0:1c7:bee6:1bfa with HTTP; Tue, 6 Dec 2022
 06:20:54 -0800 (PST)
Reply-To: halabighina00@gmail.com
From:   Ghina Halabi <yayradede@gmail.com>
Date:   Tue, 6 Dec 2022 14:20:54 +0000
Message-ID: <CAJ3hp9XBee=oj7ORQMJh1joQXhg1YhQzZxF_JciG-7Hm2Hxzqw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Hello good day,I am happy to be together with you, My name is Ghina
Halabi, I am a military nurse working with  Israeli defense force.
Please don't let my profession, race or nationality enter your mind,
there is something very important which I would like us to discuss.Can
we talk about friendship and partnership? please if you really want to
have a good and prosperous communication with me please kindly respond
to me positively.
