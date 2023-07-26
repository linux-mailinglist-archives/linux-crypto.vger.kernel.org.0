Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E517632B0
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Jul 2023 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGZJq5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 Jul 2023 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGZJq4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 Jul 2023 05:46:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C19897
        for <linux-crypto@vger.kernel.org>; Wed, 26 Jul 2023 02:46:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fd28ae8b90so46995e9.1
        for <linux-crypto@vger.kernel.org>; Wed, 26 Jul 2023 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690364814; x=1690969614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVk3D2Ovs0OQVitdb5xswV9gYU6xHuGerRDbOGRGHI8=;
        b=YtbGpl+bbWM3rTcDg4aZUCnuzhi5Xj+jW4e9Tx1UvYMbD5ctmqWK4dlB0+FcLsuEw+
         iSYIB/XmLE/wG9/TtL2NQlGEdSMI83+1h0DcpUcFBdQYpoOiI/aQCuU+kkS20yGjMnxv
         eoTOdLdUH7W0ZwLHvdeE/+I24/wJzt9nzZacXoOk1BD6Bn+dPMdCzWXrk2GqceioFr+w
         CARCA7YRVNjzvqqXrpqi9Wg+nqiVi7LxV2OA+sIJvhe9Jr0IEjl2WCTpc7/Z4I4NU3td
         186/8uB0yXTnbWkcmn6rqLmJcINHjDtkQezb4zswDpljftvJnOuf6fFt8Ut92IXDCYWU
         7/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690364814; x=1690969614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVk3D2Ovs0OQVitdb5xswV9gYU6xHuGerRDbOGRGHI8=;
        b=jpoDbVL1WxJAd0xZv7fF6FVevRkOS3vKAioezj5lHu8FMtpUYW29mnWAfYhBbgNGiH
         4LbOLIeh8nzAfnq6D/j8MJr7Gy4/rA4Cs6y9eO0XGFkgpmswmXrKrd5dAFWl+lpTXONJ
         XmDC7/6hLffNoZbX3+TINSn0+vqaG30wE/JdE4kKGpQ9mBsjBTwFDcYbsetnGurzPMMQ
         n58T2UfA5NnKQXHZk+nKR5uC3jUJUymOt4EmiDYhT8c6oayao+IDHzAuFwSsECi15/eM
         SGs0Kd3hZM9TFL2RlRWmJ1NLEZOF99z007n/A+eQYahiTNmCzkRGeJLlAv9KNI9I05ET
         Xd4A==
X-Gm-Message-State: ABy/qLa4t1AQrQW+lqdOx1M8ZSI7xyNGEUzJQSaffqUj91qS0ssUqHPD
        qJhl031gIp0TSfMigvUBEUpxe6gIYKDj7GQTOP9mXg==
X-Google-Smtp-Source: APBJJlHzycgPSHCO7xhc73QYvhqdiMVjY11q/GUx1ttiW2v8T+9YQxSks0t8zGKVP7VjXEpaJRkGP+VJ9bfKjR9IYqU=
X-Received: by 2002:a05:600c:1c82:b0:3f7:e4d8:2569 with SMTP id
 k2-20020a05600c1c8200b003f7e4d82569mr176062wms.5.1690364813965; Wed, 26 Jul
 2023 02:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000ced8905fecceeba@google.com> <00000000000002c74d0601582595@google.com>
In-Reply-To: <00000000000002c74d0601582595@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 26 Jul 2023 11:46:42 +0200
Message-ID: <CANp29Y5cQX3eOo+rB5bWcqn38bcPY7o12wcJ_WmAY6D+UxGTcw@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_update
To:     syzbot <syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com>
Cc:     alexander.deucher@amd.com, davem@davemloft.net,
        dhowells@redhat.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 26, 2023 at 1:32=E2=80=AFAM syzbot
<syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 30c3d3b70aba2464ee8c91025e91428f92464077
> Author: Mario Limonciello <mario.limonciello@amd.com>
> Date:   Tue May 30 16:57:59 2023 +0000
>
>     drm/amd: Disallow s0ix without BIOS support again
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D122e2c31a8=
0000
> start commit:   [unknown]
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D526f919910d4a=
671
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0bc501b7bf9e1bc=
09958
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13f71275280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1108105528000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

No, that's unlikely.

>
> #syz fix: drm/amd: Disallow s0ix without BIOS support again
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
