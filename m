Return-Path: <linux-crypto+bounces-23293-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HPiARtw52ke8AEAu9opvQ
	(envelope-from <linux-crypto+bounces-23293-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 14:39:55 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD243AC02
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 14:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1C9E302E881
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 12:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E73D34BD;
	Tue, 21 Apr 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsdEKXNK"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251FF3D3339;
	Tue, 21 Apr 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775011; cv=none; b=uYXI8hnVyqY+34xyGpO5MgBqJ5idzhrjVPn107PLR1QqbOanio3bm1sRsQJ3F+rnKaJtB4c/3lQUSy00ihOdO3TELqAoMohSyiRTidCqa48X15fdI6mCBvEOOx8vC6CkZWSPTaTPnX3dL0vKp/GRnw0l77RE0uVGuK47ExIGzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775011; c=relaxed/simple;
	bh=ySWjPzjlFWH5Pg0MB91iY6wBTNwzPyo4OILr+iHHSrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUd5vo3ob6WBlAbVKB9IZgyPAVE/gi7DbMgKMsXWudVNf7ERPOajYn9TINSyz+WyMD/KTzKBkzr/m7L5EKAtWJs++LJVklfj3yA1lpP+mHuSzrRUbF/fQ5x+8+fCRYkbp5Lm/29nE9kMftNQod3ntuMiuESnvsRoAePaq7qbkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsdEKXNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF61EC2BCB3;
	Tue, 21 Apr 2026 12:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776775010;
	bh=ySWjPzjlFWH5Pg0MB91iY6wBTNwzPyo4OILr+iHHSrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zsdEKXNKD7fvHRq62y5AiN4tBfmnY1WFZcHuSz7ZbfjxIPs6tzP2NDjr4ks9nO3XM
	 AgqA7BOUGjsVibNBa5S+YbiF5Or1yYKaHzBKlWAn57+vZfde6XM5f9lywcmF7Aq7FF
	 XpvNGt9lMmkKYf0djaTNfh3UbuIXfsmS7BGuEqBQ=
Date: Tue, 21 Apr 2026 14:36:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Geoff Levand <geoff@infradead.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
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
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jiri Bohac <jbohac@suse.cz>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
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
Message-ID: <2026042113-shaded-favored-c342@gregkh>
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
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23293-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,suse.com,broadcom.com,infradead.org,denx.de,debian.org,zx2c4.com,linux.dev,redhat.com,ziepe.ca,nvidia.com,linux-foundation.org,rivosinc.com,paul-moore.com,linutronix.de,suse.cz,linux.intel.com,cab.auug.org.au,vivo.com,amd.com,chinatelecom.cn,linux.alibaba.com,soleen.com,arm.com,donnellan.id.au,iscas.ac.cn,google.com,aol.com,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[93];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,dt,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,0.0.0.2:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3BDD243AC02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 02:14:14PM +0200, Link Mauve wrote:
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
>  
>  		cpld@2,0 {
>  			compatible = "denx,mpc8308_p1m-cpld";
>  			reg = <0x2 0x0 0x8>;
>  			interrupts = <48 0x8>;
> -			interrups-parent = <&ipic>;
> +			interrupts-parent = <&ipic>;
>  		};
>  	};
>  

Isn't this going to break a working system?  If not, then was this dts
file ever correct in the first place?

thanks,

greg k-h

