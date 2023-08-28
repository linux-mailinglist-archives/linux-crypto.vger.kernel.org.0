Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A7678B32E
	for <lists+linux-crypto@lfdr.de>; Mon, 28 Aug 2023 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjH1OaJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 28 Aug 2023 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjH1O3q (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 28 Aug 2023 10:29:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A80F7
        for <linux-crypto@vger.kernel.org>; Mon, 28 Aug 2023 07:29:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so4357554a12.0
        for <linux-crypto@vger.kernel.org>; Mon, 28 Aug 2023 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693232982; x=1693837782;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ2NTFSuwbgn1shPsMG7t3f98JKsP5lqwb6cWvxUrKw=;
        b=UMY9j+6RP6La4XhxzXOYoRlZCEf9Ne/sqLWjzy1HTbG5LG5fLqp6JWECLtBrMVyZ3P
         xr3wDAmM8p6m9Rp3DyP0QnmbgZS7Mz16elnGhVu/O2rKWpw93Bx2RjVp/itzvaeknjfY
         fapGEdny6ctmxkBJtlVosBLh6EoB6K+3uNHkjRlXD6cY5Z69dOVqifxT01LQKjWIdnKv
         EyIvSywP06VGnbJHM28ZWzvKriQ49SM1sGkyMnhEeAqz5g3drR/9rOCM084FMWHp781H
         PiCR+krBPZEgs98E1NK3ZC0TMV8p84rBnZ0w2QLIxMtfL7whLj+m9X1812YwPClPMxvn
         9+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232982; x=1693837782;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ2NTFSuwbgn1shPsMG7t3f98JKsP5lqwb6cWvxUrKw=;
        b=J3wSoy260Oe9C1r3seTaunx+8tu5j2pNSeVUraKk7HeWdW5DJaF3/NvR/Ot474POMy
         QqxNKTNyC94PBsVy8kd2r3Om9M9YcSZqazeA7o+YSZds1NL2eUlxDQ4wFP788EU9c6A3
         4VQuzTSV04YH6QB8Kw6shuo0jXScZZecLN6jip4JNkNdfc5dpHiq6sVNqD3gZ/3jjvNM
         7hmwqSFdouN9i7gw0Pqna9QZUGKcFKy64I3BWHX2Yk+SA5f6ycRV/vLyeZuZql2WeFFV
         jsM0Pmaq5JUjgTwO35WYo8ZzjUpH+j+pdWThoWeU7whwLXLDlrEG/y07Pg/C6BA5Y9ay
         RlWA==
X-Gm-Message-State: AOJu0YwhhV6XOhgraygxsG0Qk3nj5J3dTjic3AjHaz/RqT4S4cr9kuuS
        D871LzQy5FNA9KtK4vTcxDiZBusotlFAm/uqyFI=
X-Google-Smtp-Source: AGHT+IFt21nq0+tf8O2oPh2GNsx3SzJxohoaPqfqcBvCj+cO2iE5SMoZsJD1qqRMSognfbqDufwSqR2OEeTINfKiJhs=
X-Received: by 2002:aa7:d4cc:0:b0:522:2711:863 with SMTP id
 t12-20020aa7d4cc000000b0052227110863mr20169701edr.1.1693232982170; Mon, 28
 Aug 2023 07:29:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:214a:b0:51:f901:3cae with HTTP; Mon, 28 Aug 2023
 07:29:41 -0700 (PDT)
Reply-To: mr.richard101kone@gmail.com
From:   Richard Wilson <richardwilson9088860@gmail.com>
Date:   Mon, 28 Aug 2023 07:29:41 -0700
Message-ID: <CADnFsLAqHpJPiY8dy7Ar2r7DE+Y1AXa1kGXU8jsGR-0hMn_12Q@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9750]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [richardwilson9088860[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [richardwilson9088860[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr's Richard Wilson
