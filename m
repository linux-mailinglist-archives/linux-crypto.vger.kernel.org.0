Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297D9603B60
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Oct 2022 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJSIWh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Oct 2022 04:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJSIWK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Oct 2022 04:22:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B97C748
        for <linux-crypto@vger.kernel.org>; Wed, 19 Oct 2022 01:22:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d24so16240157pls.4
        for <linux-crypto@vger.kernel.org>; Wed, 19 Oct 2022 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCJsXsDD/iNK9yC84Ot8gXJYydwvdgJYruOO+RMKvrI=;
        b=BFSR4WVhAXfB1vlb0cUgghmsCkWBRhqgD6lVihreVgg0Ur6b0TysDdmKzJ/V3RZItP
         2VGwR/gxZPw5eLhG8UVwdrJPN6JvFW2EWGOOWUQwOOt69EkBSKMg/n+eTYeb/Xaftcpx
         0MRaeDjikhPvT4P85syFkT0PMsbBDuZLIsslwR9vIKR4pV3R266ZjiVeWWuCwDgrs1TY
         4fz6nx1kqNJL7lUmzZQzpfyxZ8gnv+qKMZxQyNMeqp02ONzGdf0nrvrzyyeSCnSzq5th
         njgOftXzyJ3pTWAFyAn364PX+ZVbZ/jg9uM7kvCsABV/zdARBWrjAbQUN/V6lHZpCCBO
         Tkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCJsXsDD/iNK9yC84Ot8gXJYydwvdgJYruOO+RMKvrI=;
        b=eCqksPHSEuNdkEkK8MUwrnFEcnOH3Twr9aGMQKtl03TXr42UhKWsfuUL2wze5ycZgh
         oeDc8xyV6nRHWcFJmygV0sD1PzDmfne6Clh3zt0LOJOniM1pUnZEXYmXFivUfYwabk8i
         57uNtjZEU+3ejz0EL70IAGwtfkGyZeM0tjf+U6+JJsuuNIbrB7uMUWN9KX9ApF+dBnZD
         Q5cY77O+Lx8vDS8vV+jMo+8x9VrP1M6y4LnCww8EVom/ANT47JQqcj+v5pFffSid8w6c
         euhgip1sFQX7zoVKLpJnXIDmz027slzHqY+arG0kVEGET1BqGYs5VI60m1aBqmI3I7B4
         eeGQ==
X-Gm-Message-State: ACrzQf1xsneBI4BfTcsEtOU9olmXJWMxW5mhdmtBu/cJm/Ovl7w8akS7
        fBlUkOuMasYwH/Q98jdbteqNY1YQFOhOLgcVbJtv+kHgfTWESg==
X-Google-Smtp-Source: AMsMyM4lpOr7xF2OuedJ06jrmINiWWb6Iolu3B6EalrgIgAhqCKEx0lTHc5iycAzzdfgxucK3mfdcaeahaKaDKVmug4=
X-Received: by 2002:a17:902:7b95:b0:178:ab50:76b5 with SMTP id
 w21-20020a1709027b9500b00178ab5076b5mr7288103pll.161.1666167400757; Wed, 19
 Oct 2022 01:16:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:d2cc:b0:185:457a:9333 with HTTP; Wed, 19 Oct 2022
 01:16:40 -0700 (PDT)
Reply-To: abdwabbom447@gmail.com
From:   Maddah Hussain <aloyikechukwu03@gmail.com>
Date:   Wed, 19 Oct 2022 09:16:40 +0100
Message-ID: <CAJLuiHSMgW28O7MG91mcZnZdzMzbkJKGna5G_xdHGbYkJx4tKw@mail.gmail.com>
Subject: Get Back to me (URGENT)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abdwabbom447[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aloyikechukwu03[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aloyikechukwu03[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.

Maddah Hussain
