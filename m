Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEDE77EFBE
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Aug 2023 06:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347980AbjHQELA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Aug 2023 00:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347975AbjHQEKd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Aug 2023 00:10:33 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44032D5D
        for <linux-crypto@vger.kernel.org>; Wed, 16 Aug 2023 21:10:31 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7aedc57ffso5623450b6e.2
        for <linux-crypto@vger.kernel.org>; Wed, 16 Aug 2023 21:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692245431; x=1692850231;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb4qAVlMN/V48c3tDnit9Qdh+68rSKImmu7s/ky4OWc=;
        b=QZVr/KEqicRI/6SEayyUCINnGyTCaHQNpUidP/rTVfZpzY4WuOMnHGcHVPKXN4Avtd
         v2Heqe2gzJDKdah5q8+CrUXrM0gbgquO1BMb3sXLowyrDdQb9bNyqDLhualr7G4ZOsjc
         6dUMsjpMSnM3V0bOiyUgHeHbgMhaGR1qwXpEmWCTeVOu5foSWdJkBMiICSSlknsgKzjT
         i11BLhBsjTOusIbMPFfUUNx099LKBDik3WnhGcmkMQAQmXKOjBWOmvzPmwLBcnW2Z4pK
         qSIRe1U1PMqbITVS5d7PRt3HFk6Ih8+6SeqgL9N+S7PfD0F8hRDBVXMKeDOVoJMboMd2
         Seug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692245431; x=1692850231;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gb4qAVlMN/V48c3tDnit9Qdh+68rSKImmu7s/ky4OWc=;
        b=SQKui2M2HoNSXGn/x2iR7GcZ3mOKF4dB+0jKemLeSesgpLS1bupFEp5KQ0ZmvFGpux
         2Jgv+AoxolkZvCkP9A1JOsqLIkFzl2r5OpfIGvE8Whns5+pH/DAtQP7hV6kZGen4puv7
         g9iYPiK7Xb3eBlgjqUtbNhg/tG2G2AgPBQeTkx7ZOvabzxFjS1Mv55h1Fo3YVKhVzT0p
         KLfKjSVvaqbDLk+lrMPVEeGS5iqzwDWReTQisHd+BKK5hln+uVTqSILO/XC9AumWIISe
         5QJzNMdabV0qvGc0iVaVGL6jRoEzkfZjgLZ5YHEiz9BqwrmUXhlx5e3I1lpya3roTRaR
         WznQ==
X-Gm-Message-State: AOJu0YzY7N+RjwvlRcNeH9ZmK2R72sANKmMeJKYGLZp/xNXXP/YAEEjZ
        4Ud78Y9Im6iOAxmCzPyPqWR5NBg20tXP8aE9EKA=
X-Google-Smtp-Source: AGHT+IE+EUtZMOEKAqBMqqYWqu/RGZn+LQHYrEoeh4RZ4kAZ5+7Cge6AatfGuElbDFAwVCFeG3d4+yjCF93CGJg6ub4=
X-Received: by 2002:a05:6808:211d:b0:3a7:500a:a481 with SMTP id
 r29-20020a056808211d00b003a7500aa481mr5048636oiw.3.1692245430889; Wed, 16 Aug
 2023 21:10:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:d099:b0:133:91d:bed5 with HTTP; Wed, 16 Aug 2023
 21:10:30 -0700 (PDT)
Reply-To: privateemail01112@gmail.com
From:   KEIN BRIGGS <privateemailjsuee@gmail.com>
Date:   Wed, 16 Aug 2023 21:10:30 -0700
Message-ID: <CAGgyiOpF7Zv46NvVHY4rvTo1qBA_8ijKgS9y7fMp4AZEZxHXwQ@mail.gmail.com>
Subject: Your attention please!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Your attention please!

My efforts to reaching you many times always not through.

Please may you kindly let me know if you are still using this email
address as my previous messages to you were not responded to.

I await hearing from you once more if my previous messages were not received.
Reach me via my email: privateemail01112@gmail.com

My regards,
Kein Briggs.
