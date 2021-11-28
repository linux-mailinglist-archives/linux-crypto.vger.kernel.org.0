Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C358246038B
	for <lists+linux-crypto@lfdr.de>; Sun, 28 Nov 2021 05:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350305AbhK1ECl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 27 Nov 2021 23:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344092AbhK1EA0 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 27 Nov 2021 23:00:26 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397DC06175B;
        Sat, 27 Nov 2021 19:57:11 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l8so12924470qtk.6;
        Sat, 27 Nov 2021 19:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFV+i9qtOAvvG/eHCEjEWYh2+rKTUYToGFh2vpYai2U=;
        b=chiNDciN+mw9g7Ak1NHLuh8JPanlDYqkr1Pqo9eXdqgWZ0s7k4fLNVOVPgZUy6fkjm
         kaMyVzCokAqk119GQ8bzMKTD05UnC2FTd2NOgUZAuBVJtU7OP6dPqa5dQADPwgyWsto1
         Qv1eYll6UW8OHMmGkZcKU7HQROuuQpM5PrHzE0PCqYInI5DE0pZxTqf6wqpbepCFwaYA
         7371+oA9ttpW8PTeiT4qmfRXFL7wexA7P+pfduuTdwQnWhGwAzwYwRUFFxeLfik+qWvy
         kjSjMD+0Dx+qa8H1ARTwTRP8Y3AdRV2VBfJsjVegnLilYyAezvNXn/8F0Y7/ZQsYb6VK
         yFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFV+i9qtOAvvG/eHCEjEWYh2+rKTUYToGFh2vpYai2U=;
        b=rmOeztLl5O+PT1nqDri2igBwOdHkltP3Zh33yBVU4ABw9P5NQzAjw+enDliljeALXN
         jkRsq7I17/Wu3K1BFfx+gbU6gHQt99oloS09pqPjs2nztZZQX+y11AwZw7/rOjDcFMz7
         pNQX9F+7GKe3fzrcjI0S7O2xA2f4KW8Wswpk+AQxuqyQFN9ZVzdn+sZP1h/dSp9ynd5+
         L5Zy5a/0k/xNa+zi6Xuo1/Kz5ZpOuFxig01s2xzTx+k3DCrHskuc591/euVmIQtD4bcs
         7uXofzjTjY+yCUsifUtCxxcjEhtXkHC2HT74kCGgOn4WSdGN9fvCM5wHBFPo3u70MjcK
         Y8OQ==
X-Gm-Message-State: AOAM531P65U8I6fYmafnnVlUFkN6pfkPWlh1toEyvRdlU3r9g9bInIZK
        nBgdC4lchul7xVq934+KaJZqC++0IkDAzg==
X-Google-Smtp-Source: ABdhPJx6di3732tCAyUxsq9O1g2QIq9JweBndJPZX/iKhmJAAwkV4ErxZy2apf/gFLKoKAQwTFkjag==
X-Received: by 2002:a05:622a:1191:: with SMTP id m17mr26072570qtk.595.1638071830496;
        Sat, 27 Nov 2021 19:57:10 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id h19sm6555265qth.63.2021.11.27.19.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 19:57:10 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Gross <agross@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geetha sowjanya <gakula@marvell.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jens Axboe <axboe@fb.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Marcin Wojtas <mw@semihalf.com>,
        Mark Gross <markgross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Solomon Peachy <pizza@shaftnet.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Tariq Toukan <tariqt@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/9] lib/bitmap: implement bitmap_{empty,full} with bitmap_weight_eq()
Date:   Sat, 27 Nov 2021 19:56:57 -0800
Message-Id: <20211128035704.270739-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128035704.270739-1-yury.norov@gmail.com>
References: <20211128035704.270739-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Now as we have bitmap_weight_eq(), switch bitmap_full() and
bitmap_empty() to using it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 996041f771c8..2d951e4dc814 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -386,22 +386,6 @@ static inline int bitmap_subset(const unsigned long *src1,
 		return __bitmap_subset(src1, src2, nbits);
 }
 
-static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
-{
-	if (small_const_nbits(nbits))
-		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
-
-	return find_first_bit(src, nbits) == nbits;
-}
-
-static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
-{
-	if (small_const_nbits(nbits))
-		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
-
-	return find_first_zero_bit(src, nbits) == nbits;
-}
-
 static __always_inline int bitmap_weight(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -436,6 +420,16 @@ static __always_inline bool bitmap_weight_le(const unsigned long *src,
 	return __bitmap_weight_le(src, nbits, num);
 }
 
+static __always_inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
+{
+	return bitmap_weight_eq(src, nbits, 0);
+}
+
+static __always_inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
+{
+	return bitmap_weight_eq(src, nbits, nbits);
+}
+
 static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		unsigned int nbits)
 {
-- 
2.25.1

