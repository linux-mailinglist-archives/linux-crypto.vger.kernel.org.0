Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00444735D84
	for <lists+linux-crypto@lfdr.de>; Mon, 19 Jun 2023 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFSSjb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 19 Jun 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFSSja (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 19 Jun 2023 14:39:30 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367D18C
        for <linux-crypto@vger.kernel.org>; Mon, 19 Jun 2023 11:39:29 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77e45f12b5bso38131239f.0
        for <linux-crypto@vger.kernel.org>; Mon, 19 Jun 2023 11:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687199968; x=1689791968;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yovt+NBs+zN88mKTFmMiBGRNaqNl1IAEsWQ9bmrlOts=;
        b=OqmjTEIWxneoIuK16ehNhdwfYFU8FhA8Kn842A0s/2qWEHHAj74++mKSqSbTs+vnHd
         jyf21nCceSTv/0YfmKOMu4S0QJPn7sgkYkhl9GQtjT+1+yVC6NMCsff+cXROzI6yHqDw
         xQWFHIrW+sdaIBg0RoFsO0vNPo+IrT4HVI/Ifwq4gtbJKW/0P9VNEPXlj8zPagFs/1oE
         0mXsdG21i+W+Mf4adwp6UuMps712LfgOpAQpJkXXnh7joUbx1lvBOZVlGKbER45Ys3u0
         e6CR9ltzaxybwoTEIEBTSpe5TSlaxGNTdKmtQ/fJevqgpiUH5Vg8nMXmtb+6QVeJvrXU
         mpoA==
X-Gm-Message-State: AC+VfDwwqTFPSALSMChQ25PJeNToAgYZH2f1e7533hUjA0b+fre/2PXi
        t09XcjG5umDWVtlQEH5ZgJ0CzlT09Am7nsaSakKTXjpSxNjO
X-Google-Smtp-Source: ACHHUZ6Zu1qOfU3n1nK17F8mRHVcVw++7U+FWtv+g1pIs1eCeFRAessPwU2LszmlMeaaiY97WhjTMdQEA9nxqde2iw2xAZuCWbTM
MIME-Version: 1.0
X-Received: by 2002:a6b:3b8b:0:b0:777:b0ee:a512 with SMTP id
 i133-20020a6b3b8b000000b00777b0eea512mr3574163ioa.2.1687199968282; Mon, 19
 Jun 2023 11:39:28 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:39:28 -0700
In-Reply-To: <000000000000ada87505fe7cf809@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6527105fe7fdab8@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_ahash_update
From:   syzbot <syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

syzbot has bisected this issue to:

commit c662b043cdca89bf0f03fc37251000ac69a3a548
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jun 6 13:08:56 2023 +0000

    crypto: af_alg/hash: Support MSG_SPLICE_PAGES

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a7cbcf280000
start commit:   9a94d764e9bc Merge tag 'mlx5-updates-2023-06-16' of git://..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a7cbcf280000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a7cbcf280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a7d74e6a7c3211
dashboard link: https://syzkaller.appspot.com/bug?extid=88f4b1e6cf88da11f5cd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1152c4ff280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1307cbcf280000

Reported-by: syzbot+88f4b1e6cf88da11f5cd@syzkaller.appspotmail.com
Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
