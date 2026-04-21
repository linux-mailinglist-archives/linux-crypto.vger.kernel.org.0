Return-Path: <linux-crypto+bounces-23296-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH3QMN6u52lZ/QEAu9opvQ
	(envelope-from <linux-crypto+bounces-23296-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 19:07:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1736143DBCE
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 19:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB0F301CF80
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B63845B7;
	Tue, 21 Apr 2026 17:07:31 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113D1509AB;
	Tue, 21 Apr 2026 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791251; cv=none; b=YoLVRP0rELpxGlS4rxsWEocB5iqK/F4XRFaPLOyRf4qkL5Sj7ocK6fh+ElZ++lxGds/hy8CLE+yK43WPlGS0PzTsN3UYHPPu6wcg3j5oOtq3Gl2bHIeZjP7t7UiIMBnRVG/6t6oP2c6OH6NNZl5hYN47mi99cjxjn2wAUMb1jaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791251; c=relaxed/simple;
	bh=BmLatGy8n1zKmv3W1i69jDYO1lD52eKYiSdHSJdTpeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWmmbShRAnnRWeyuIgfALBggo4xC11vz7zRyTtJodnrjqaCuRUb28Y7iawPTgFYWVitNK4etXALUVQ2BeBV5KeMyrhRlr4p2vuvEMeGLlJ8FerHQlwVTMI6e9/6tnHwitHWvoS/I2zUj8sz1JPQYSlmLpWy70oOUfdDZU4As4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63LH4FuA3771909;
	Tue, 21 Apr 2026 12:04:15 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 63LH47sR3771903;
	Tue, 21 Apr 2026 12:04:07 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 21 Apr 2026 12:04:06 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Geoff Levand <geoff@infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Anatolij Gustschin <agust@denx.de>,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Thomas Huth <thuth@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Donet Tom <donettom@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        Paul Moore <paul@paul-moore.com>, Nam Cao <namcao@linutronix.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Kees Cook <kees@kernel.org>, Stephen Rothwell <sfr@cab.auug.org.au>,
        Xichao Zhao <zhao.xichao@vivo.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Guangshuo Li <lgs201920130244@gmail.com>,
        Li Chen <chenl311@chinatelecom.cn>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Feng Tang <feng.tang@linux.alibaba.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Sayali Patil <sayalip@linux.ibm.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Yeoreum Yun <yeoreum.yun@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        Athira Rajeev <atrajeev@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Chen Ni <nichen@iscas.ac.cn>, Haren Myneni <haren@linux.ibm.com>,
        Jonathan Greental <yonatan02greental@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
        Gaurav Batra <gbatra@linux.ibm.com>,
        Nilay Shroff <nilay@linux.ibm.com>,
        Vivian Wang <wangruikang@iscas.ac.cn>,
        Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Thierry Reding <treding@nvidia.com>, Yury Norov <ynorov@nvidia.com>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Ruben Wauters <rubenru09@aol.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH 2/2] powerpc: Run typos -w
Message-ID: <aeeuBnjhRN7G9gYK@gate>
References: <20260421121420.26079-1-linkmauve@linkmauve.fr>
 <20260421121420.26079-3-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421121420.26079-3-linkmauve@linkmauve.fr>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,suse.com,broadcom.com,infradead.org,denx.de,debian.org,zx2c4.com,linux.dev,redhat.com,ziepe.ca,nvidia.com,linux-foundation.org,rivosinc.com,paul-moore.com,linutronix.de,suse.cz,linuxfoundation.org,linux.intel.com,cab.auug.org.au,vivo.com,amd.com,chinatelecom.cn,linux.alibaba.com,soleen.com,arm.com,donnellan.id.au,iscas.ac.cn,google.com,aol.com,vger.kernel.org,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23296-lists,linux-crypto=lfdr.de];
	DMARC_NA(0.00)[crashing.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt,kernel];
	HAS_XAW(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[segher@kernel.crashing.org,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_GT_50(0.00)[94];
	DBL_PROHIBIT(0.00)[0.0.12.28:email,0.0.0.1:email];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1736143DBCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

On Tue, Apr 21, 2026 at 02:14:14PM +0200, Link Mauve wrote:
> diff --git a/arch/powerpc/boot/dts/fsl/ppa8548.dts b/arch/powerpc/boot/dts/fsl/ppa8548.dts
> index f39838d93994..32558104b3a9 100644
> --- a/arch/powerpc/boot/dts/fsl/ppa8548.dts
> +++ b/arch/powerpc/boot/dts/fsl/ppa8548.dts
> @@ -95,7 +95,7 @@ i2c@3100 {
>  
>  	/*
>  	 * Only ethernet controller @25000 and @26000 are used.
> -	 * Use alias enet2 and enet3 for the remainig controllers,
> +	 * Use alias enet2 and enet3 for the remaining controllers,

Aliases.

> diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
> index 41f917f97dab..48a98449ecbb 100644
> --- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
> +++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
> @@ -90,14 +90,14 @@ can@1,0 {
>  			compatible = "nxp,sja1000";
>  			reg = <0x1 0x0 0x80>;
>  			interrupts = <18 0x8>;
> -			interrups-parent = <&ipic>;
> +			interrupts-parent = <&ipic>;
>  		};

interrupt-parent .

All the names of properties have a meaning!  Just as you cannot change
a function name in C without changing all calls to it as well, you
really should never change a property name (if you want stuff to keep
on working, that is ;-) ).

In this case, the property was never actually used (because of the
typo).  Maybe it wasn't needed?  If you make changes to a DTS, post it
*separately* from the rest of this series, and test it *thoroughly*.
Just a "does it boot" test is certainly not enough.

It could well be that fixing the typo (so that the property name becomes
"interrupt-parent") makes the kernel no longer boot on the systems
affected, or less obvious problems can show up.

It will need to be tested and evaluated by whoever maintains the DTSes
in question, really :-/  And you cannot test it works for one DTS and
then conclude it will work everywhere, heh.


Segher

