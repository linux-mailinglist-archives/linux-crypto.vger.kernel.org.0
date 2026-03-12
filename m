Return-Path: <linux-crypto+bounces-21887-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFxTILFZsmnHLwAAu9opvQ
	(envelope-from <linux-crypto+bounces-21887-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 07:14:09 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 116DD26D833
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 07:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D88B3021B88
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 06:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C994381AF2;
	Thu, 12 Mar 2026 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6L00UJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6x7Lg3O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6L00UJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6x7Lg3O"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A29937EFF0
	for <linux-crypto@vger.kernel.org>; Thu, 12 Mar 2026 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296046; cv=none; b=a1jsqLE+Y/2kVxtOsN3AMuLBEy5U4FrlrjYjsyWekKQdHuPXtlar9S/0b/oAndhX8wsCmBMFu2N7Q1J/T7ieO6Uu4WAnwi2tvcF5fTTG9ieT2cj9wp7dNjDJftv104oIHzJXW+mSlYctHkNz+QVzVHbNv0K5pzgbTQ2RQGo0xW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296046; c=relaxed/simple;
	bh=jzGHso5K3r2R3vYKB+f4MvfQOG/Mgg2LUyfLm3OiSBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6WyFXxYZyRc+/6nTw8RlgUf4n74XVL4/BVYZJjHseTUJqfRujc6aWXth7nd8JGYN+3a5F2AJAWQSHYR0n38EADsvNRfHFVQf2DoNrHrvoPGcVFZMimeljdRBbvyCUZUJjQzwo/ycL54jJgOfbNq7+TuiNF7rGEC7EQCU4VprOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6L00UJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6x7Lg3O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6L00UJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6x7Lg3O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 506BD5C0AB;
	Thu, 12 Mar 2026 06:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773296043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTMk2W3stj8+PWnN98r8nUX6IrcWOaSqaGU5Q2vEZzo=;
	b=L6L00UJL1VQ6IEp2O5xa2lEsD0gVDNhh1KSA9k22B3AHJTezID+Dj3OxnBK0Ob7Ja3/cc+
	FoNKQ2oLlWIi7mruL9dJhikXx/B5hbXJQ0fYtgSArLVPWcr1RjAhojHuu493p2im/SwbMf
	u3LqEuCjY14qQ6o/v/9Dv4+xFtPYBg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773296043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTMk2W3stj8+PWnN98r8nUX6IrcWOaSqaGU5Q2vEZzo=;
	b=L6x7Lg3OeWIL6ALQIVkElvYX8trulqusN6FrtbYfTfixUGs7gjqDdkJnsWLXscU1dnEyWh
	HJGthSgH431PfKAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773296043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTMk2W3stj8+PWnN98r8nUX6IrcWOaSqaGU5Q2vEZzo=;
	b=L6L00UJL1VQ6IEp2O5xa2lEsD0gVDNhh1KSA9k22B3AHJTezID+Dj3OxnBK0Ob7Ja3/cc+
	FoNKQ2oLlWIi7mruL9dJhikXx/B5hbXJQ0fYtgSArLVPWcr1RjAhojHuu493p2im/SwbMf
	u3LqEuCjY14qQ6o/v/9Dv4+xFtPYBg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773296043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTMk2W3stj8+PWnN98r8nUX6IrcWOaSqaGU5Q2vEZzo=;
	b=L6x7Lg3OeWIL6ALQIVkElvYX8trulqusN6FrtbYfTfixUGs7gjqDdkJnsWLXscU1dnEyWh
	HJGthSgH431PfKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C3EF3FE12;
	Thu, 12 Mar 2026 06:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9PbNAqtZsmmBXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 12 Mar 2026 06:14:03 +0000
Date: Thu, 12 Mar 2026 07:14:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 23/27] btrfs: use xor_gen
Message-ID: <20260312061401.GE5735@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260311070416.972667-1-hch@lst.de>
 <20260311070416.972667-24-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311070416.972667-24-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,mit.edu,zx2c4.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21887-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_GT_50(0.00)[57];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 116DD26D833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 08:03:55AM +0100, Christoph Hellwig wrote:
> Use the new xor_gen helper instead of open coding the loop around
> xor_blocks.  This helper is very similar to the existing run_xor helper
> in btrfs, except that the destination buffer is passed explicitly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Sterba <dsterba@suse.com>

