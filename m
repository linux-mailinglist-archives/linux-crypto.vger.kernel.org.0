Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E1368F99D
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Feb 2023 22:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBHVRw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 8 Feb 2023 16:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBHVRv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 8 Feb 2023 16:17:51 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78522E0F7
        for <linux-crypto@vger.kernel.org>; Wed,  8 Feb 2023 13:17:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id lu11so744652ejb.3
        for <linux-crypto@vger.kernel.org>; Wed, 08 Feb 2023 13:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7K3SdsX+o6Xs8DenIJv/GPl3eqRlM7oJKb2XOYZBFDs=;
        b=D+ikUZbWgeUudplA5po5W5M5DxMh/6Jj7uZ7xBBpP1mIyMfKrZtcU86MtTohiWsoE7
         V6rxZrRkUhgwDDElEuAYS+r1rkH2Yqe3iVsRpWQkmb6Eqi3MCQ7kespJEMYz3UIKv6gF
         y2hX4XKoO/MSV16sGSgRyQymVl5N1IigURddMk+WzFE3fKX2cDcGAIWkpuCcEG9OuNxh
         PRfRRlN/J8J24ii38s9kRABckLc7fgwCv5K/20u445+dDNpsvo7rZaqSVFbgJqrHh+Dm
         jiUCBOlkpJ6bLXtsIN2Rz/CnVZaXjYAHmERgNQ8Zx+n11GMtjO++fG/rNMaD9sYf7mjn
         fQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K3SdsX+o6Xs8DenIJv/GPl3eqRlM7oJKb2XOYZBFDs=;
        b=OoPRxnCtvXVMS28RLzY8TXgn9D6JREBhLchhix4RGcVDZsdCZlOq6OXp6BXgX1dhXW
         fFVLQN1ZIV5JXlCSL6Qp872gLRh5N7K57FZ2hUlOm7rkzQTh6hgQXzW7ieswe2xFD0el
         g/AV5aNYRO+AFuceKzzmH6O0YP9O1uJXQtr6s9NEoZUaASM2hlAFnyfkbaJ3WHXvAoSx
         Vy3pTYHuUEUz9QoCUq3xnvBEuuXtopufa5C7fyjTL+Bjb4Bmek4tXDiFUfgG1NLrjq8B
         uuvCuznzYBfbAy/pLa4H0l/8yIOB3oiSzxwd0YsG1tZn1BIvEWBkzTD7PH/Zz7JPMT75
         qrIw==
X-Gm-Message-State: AO0yUKWSEKmHXJcgOPnc390BmXY70eivGYN8z6woVWm0ybiPoDZqEZf+
        BltqLT4pNdxDNIaZbI2qwUSSzOx89DH/QK9MVMHvNfiWwRElxw==
X-Google-Smtp-Source: AK7set+N6ero7aIdk0QcVk+kKKwUN65NMfSrpAXIHmhWGjsbw6ACdMLdqJhFGUJloDYiCTH2v8kdUnU5DyaqCTaelzU=
X-Received: by 2002:ac2:5594:0:b0:4cb:f3c7:7a52 with SMTP id
 v20-20020ac25594000000b004cbf3c77a52mr1497960lfg.193.1675891059094; Wed, 08
 Feb 2023 13:17:39 -0800 (PST)
MIME-Version: 1.0
Sender: mohammedaahil30@gmail.com
Received: by 2002:ab3:7303:0:0:0:0:0 with HTTP; Wed, 8 Feb 2023 13:17:38 -0800 (PST)
From:   =?UTF-8?Q?ELIZABETH_=C3=81LVAREZ_GARC=C3=8DA?= 
        <elizabethalvarez7garcia@gmail.com>
Date:   Wed, 8 Feb 2023 21:17:38 +0000
X-Google-Sender-Auth: hOHP1Ys_AfYTAhgHVyPF3OeB-Gk
Message-ID: <CALoWANixkoXQtFT462Oho34Ad53NxxVLuWPv853KsY2f4LuYzg@mail.gmail.com>
Subject: Congratulations!!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Congratulations!!!
This email ID was picked among the Coca-Cola 10 lucky Winners,
please contact the agent for more details and to claim your prize.
Thank You
ELIZABETH =C3=81LVAREZ GARC=C3=8DA
Public Relation Officer
