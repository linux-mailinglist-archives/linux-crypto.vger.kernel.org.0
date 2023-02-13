Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1E694461
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Feb 2023 12:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBML0z (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Feb 2023 06:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBML0x (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Feb 2023 06:26:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B2C14E82
        for <linux-crypto@vger.kernel.org>; Mon, 13 Feb 2023 03:26:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so11814023pjb.5
        for <linux-crypto@vger.kernel.org>; Mon, 13 Feb 2023 03:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej5cJ0bimhBEf89Yfmkn/U4PWmn8hXBIRDemQs7Zzkk=;
        b=QA6HKsdI/8PbpJvyxbV/WO1mAKN08v4Ew2Xm4V9/u/7Qq52H6DNekJ+KkAIlFprXFd
         nctdm7q1xTE6U8ZyeCRugpXDNTQahXeOlCLZs688PljzqtFHuWWSqaEe2NrAuHUD6k/5
         ski9P/UCv5T+9OZA0T99/VTwivumSZ5KLhm38a/J29l2i93Txr5Q4iSStuA5NC1z2EvV
         trYn++aZPFOZ8xJUu2YcM2GgukD72KGjCDYr5W0zcTHafQ0pAGqhxS4UZ5O5Q5GVQyq9
         HdfCCKwwd5MWtUYKGGOUGwZkedWTNY8DWn3rMpM88DwNwHkIobh6WV56+27oU6JSFWA4
         Q7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ej5cJ0bimhBEf89Yfmkn/U4PWmn8hXBIRDemQs7Zzkk=;
        b=L1fVEVPDBSh1ckT7sagX5h33/QTo7E02Ow4w4tvO0zO91sxjGVvxu7pfnpGm0gjWGt
         etdrvA3v3mJDCmjYwy1MqqJ0ls1gsGH5f1ev5S9rFQmZAE3aXkT+s+BdCnvrYbdo4A3O
         kQxICJvxRwhtKRVfV0XVpClyqRGH+JeLyhR9/BoLoTHNw7eN8lqFotjf+VMMNkgSjgk6
         BROs8vvo6wdCJ8ZZvf7bq3rQfcsl4gIN5EbSx4TaIe/vOWh55SZStPPwKdOn3N1geanu
         X8oqTcObbgHLmS6mJ2pUjs5RkSRA3nllmFHUJEkqD3CI+Q6ady/GE9lSMZRTA1We6gm/
         Dp4A==
X-Gm-Message-State: AO0yUKXDaag8vrrFyuwqeIYIrAl/0BxAdCuQ2wuH20XUJ1nnWmfw4Nva
        IKEzSoB8e/pdl3MAz5cvZh/xLMCHq1a9ZhSaVlo=
X-Google-Smtp-Source: AK7set+mgcY4Sa5TGxCxWayYlYHjyHuMUqVMLDbPQ6UCZ5VQekd6713OENgUUEXSAKY9gMLsBvH8ik6nsxycwDWws5w=
X-Received: by 2002:a17:90b:78a:b0:230:fd8a:de61 with SMTP id
 l10-20020a17090b078a00b00230fd8ade61mr4414851pjz.83.1676287612685; Mon, 13
 Feb 2023 03:26:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:689a:b0:5d:8b91:5f62 with HTTP; Mon, 13 Feb 2023
 03:26:52 -0800 (PST)
Reply-To: ahesterann@gmail.com
From:   Ann Hester <paterjohn96@gmail.com>
Date:   Mon, 13 Feb 2023 03:26:52 -0800
Message-ID: <CAL3zkxQJhn0xXor7YDpwQKXZyu3u3Tgm-_A13U3CWGmz4xW+Og@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
Hello Dear Good Day,

I hope you are doing great,

I have something important to discuss with you

if you give me a listening ear.so that I can

write you in details thank you as i wait for

your reply.

Miss Ann Hester
