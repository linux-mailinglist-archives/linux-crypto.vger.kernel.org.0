Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A399267AC83
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Jan 2023 09:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjAYImX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Jan 2023 03:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbjAYIkS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Jan 2023 03:40:18 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9645421A
        for <linux-crypto@vger.kernel.org>; Wed, 25 Jan 2023 00:39:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5065604854eso36234667b3.16
        for <linux-crypto@vger.kernel.org>; Wed, 25 Jan 2023 00:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7ancMifNNyjJiTof8bzSGdh+LvtuOAZ/yhUxoIZ6EY=;
        b=l/hcCYqvcIly8bHSP154OLa3geKFmW7WOJHtqW6QP0WOiQCkjUgO6NFBclTznfTfXd
         q/KZ4uqcFfz6e/A7WhMCPvMZlY7cpI5ZXPygAYrMACNGYIbdZdn2/wrvbiLbPFMi0EJU
         e2xhTpttA9V49soY/4kK5pbOiY/jtu7/UBbsL9M2oZElpThGo5ueYxij1daBdATn/U6J
         lFgz4QPoUTVqu2tO2Jv29c+EKfKlUr82uf6j5jrJG0K4kH7t4tXslYBl2iUfCiGyJg2L
         sa2ZzT9fi8Nbfwma/h4EwurZmwhJrp5hy3f2wiTWrdCgSBqaWH+IxEwCQ2mYpS41PmTz
         ZJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7ancMifNNyjJiTof8bzSGdh+LvtuOAZ/yhUxoIZ6EY=;
        b=R02EIGTTxRPr0mK2w05mf2GbGakyOy1w18HrLDI+Ta45YCx8QXDk/pcIEEy7SnU3qJ
         QIRA7GA7Sm9YqFw9dYQ9lYw9OpfkKbGW9YrVTNhFda/Szof55lDhfCbsBKhUc2Y6TlUj
         nFbZG2ysNbos0tg8cwN8vpZg6/yQE+UVk7bcYfgdrEHLfj6wMa7E6Me1Fj6KdPTH2A6b
         7duRIiuB3mWjeFldouP6/gIOrQSDCmnFZZc+LqxLkUsUtvxt3tY8cr1KUomrZN7QHTBc
         rFYYmu/hJG90UXCWWrF/ffeIBxY1bWNGfyvN03BGONyHltwups61cFzwzzHU4IswdyqB
         1mQg==
X-Gm-Message-State: AFqh2kotBNssC9nSvE7YHyJ5gBLp3gM1dM14QMtJw8oYEcJHGs0HrsNx
        sccgwNR93WMCLEEZwoYGm02vHKyfiaU=
X-Google-Smtp-Source: AMrXdXslOvF1txeQ7QJk1q8MehIUDQnhzGgaj+Ckxm4gdtDkml40uAzU8COPOn8c5wwtHui85E8JZje3JZk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a0d:ca88:0:b0:501:80db:3eca with SMTP id
 m130-20020a0dca88000000b0050180db3ecamr2010555ywd.100.1674635950405; Wed, 25
 Jan 2023 00:39:10 -0800 (PST)
Date:   Wed, 25 Jan 2023 00:38:51 -0800
In-Reply-To: <20230125083851.27759-1-surenb@google.com>
Mime-Version: 1.0
References: <20230125083851.27759-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125083851.27759-7-surenb@google.com>
Subject: [PATCH v2 6/6] mm: export dump_mm()
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        chenhuacai@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, l.stach@pengutronix.de,
        krzysztof.kozlowski@linaro.org, patrik.r.jakobsson@gmail.com,
        matthias.bgg@gmail.com, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        tomba@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
        ray.huang@amd.com, kraxel@redhat.com, sre@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        dimitri.sivanich@hpe.com, zhangfei.gao@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com, hdegoede@redhat.com, mst@redhat.com,
        jasowang@redhat.com, alex.williamson@redhat.com, deller@gmx.de,
        jayalk@intworks.biz, viro@zeniv.linux.org.uk, nico@fluxnic.net,
        xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, miklos@szeredi.hu,
        mike.kravetz@oracle.com, muchun.song@linux.dev, bhe@redhat.com,
        andrii@kernel.org, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, perex@perex.cz, tiwai@suse.com,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com,
        linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org,
        loongarch@lists.linux.dev, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, nvdimm@lists.linux.dev,
        dmaengine@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org, kexec@lists.infradead.org,
        linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        selinux@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

mmap_assert_write_locked() is used in vm_flags modifiers. Because
mmap_assert_write_locked() uses dump_mm() and vm_flags are sometimes
modified from from inside a module, it's necessary to export
dump_mm() function.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/debug.c b/mm/debug.c
index 9d3d893dc7f4..96d594e16292 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -215,6 +215,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->def_flags, &mm->def_flags
 	);
 }
+EXPORT_SYMBOL(dump_mm);
 
 static bool page_init_poisoning __read_mostly = true;
 
-- 
2.39.1

