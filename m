Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A823368D664
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Feb 2023 13:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjBGMXt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 7 Feb 2023 07:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBGMXs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 7 Feb 2023 07:23:48 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70C18A91
        for <linux-crypto@vger.kernel.org>; Tue,  7 Feb 2023 04:23:47 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5258f66721bso144845397b3.1
        for <linux-crypto@vger.kernel.org>; Tue, 07 Feb 2023 04:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nl8gMzgNulZ4LYAO15FTK9VoOiqGmRJe3WT69ZA8AuQ=;
        b=e9W6BcXUJ19kLD3aaluM+EX0/vyq9/tAaHc5bxqxOxPSTUR9fx9WSK/YTsTY0PA1K5
         qegitaOWq+cmK7WpyrGp7rf0FQPnLHSRAoShKoewLbWv/uYVvkIqJjknPZ9j5aFOai4d
         jeJx3Ru8uY3Fh2tzbUfonCl84Xxk2NKmZI3KUsbq7WO7hqbv7bHr8kAlhREkYSCEwKXt
         T8Iv5QBSqsT02atL5wfTYhkvyhSKC4MVb2wsdbhGjZvtZqjoPAiHYP3V9Czl30F5BcV/
         6c8FVQVsUHsKFv7JWhDMQI3J0FDH56cQkz16tUJEnZWP7BxO+9NZD3fvCkoV69KOMN/1
         GMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nl8gMzgNulZ4LYAO15FTK9VoOiqGmRJe3WT69ZA8AuQ=;
        b=Cy1K5HWUq9qYgJ2ryU7Gfmc6DaTWWlpW8GqHxCDfjcUDgl6wINzjuUmIgWKf1q+K+N
         PBvt/3HvTOMsCtdGYJgSvyfWsoPAmSK0W4AsszyTuEAVQmF1+2XeIlKoI0Bj0stPxm/5
         Hai5TCcSd1L+GlNT4BQYFJHTDZn27cMLBK6XQAwJrEOLtoljAe18xhOX08dssMhAlcVY
         v6P1fkxu+H7NyrOQEKC6qlyOmcZ5P5b4lMciR0NZohBRddULRvjUpZvd1pUxyjnjroEO
         X05n2f6K2Xf5mJauL8RjB76fdKzsl/tSSU82+JCzKxzMatF8rWvBWOyDVAeicYb203Ep
         EGIQ==
X-Gm-Message-State: AO0yUKXrpUlnHTMiTnVbbz3vFe0WCvUqGeMz51K5ioCi+EGey46R4caa
        LN/ALW4gSWLPV2hmJrARV6go2h3L8ZIpo4cKy6g=
X-Google-Smtp-Source: AK7set8GkajO5hSLaXWWfStoMZwsgO9yzczHiC9aYuEpR/jD//ESkJ2W/HdR9fZwPbcqE9ifsOKHNwQ309U+UIBrfJQ=
X-Received: by 2002:a0d:d187:0:b0:4f0:64a3:725a with SMTP id
 t129-20020a0dd187000000b004f064a3725amr294315ywd.229.1675772626785; Tue, 07
 Feb 2023 04:23:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:9b97:b0:479:d4c:ecf1 with HTTP; Tue, 7 Feb 2023
 04:23:46 -0800 (PST)
Reply-To: cynthiaaa199@gmail.com
From:   Cynthia Lop <cynthiaaaa199@gmail.com>
Date:   Tue, 7 Feb 2023 12:23:46 +0000
Message-ID: <CALungV_r=T7osugMwpuN5Q6CY-TdaSSfG5CbcLYOeMoW2HDNxQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cynthiaaaa199[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cynthiaaaa199[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cynthiaaa199[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Goodday , I saw your email from facebook.com

I am Miss. Cynthia from United States ,I work in Ukraine Bank ,
I contacted you because i have something important to tell you ,
Please contact me back  for more information,
