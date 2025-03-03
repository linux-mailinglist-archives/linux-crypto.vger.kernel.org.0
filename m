Return-Path: <linux-crypto+bounces-10355-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879CDA4CE7F
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Mar 2025 23:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16EA3AD537
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Mar 2025 22:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04152238142;
	Mon,  3 Mar 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Roj3/glZ"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62C236450
	for <linux-crypto@vger.kernel.org>; Mon,  3 Mar 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041548; cv=none; b=pwHknfzjULoh4O320vN+iXkOm5kLDSDdeMRSUK+CVJpiBNBdJDW+G5XCzhcTQVozlR+v8KWuG2ccgd3mUCNy7tN9RS8L4XoOxG8c1R+8DrqaOPrLuRl+z6d9S0HQN7hx81j5Dg/kPvwkKpdiWhmNCJW/Zpu/HzkbtE/c+IXyQks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041548; c=relaxed/simple;
	bh=ANe3vlyacW/Ns1QjEclsVevS/opWODpF/10+wEixLF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prfuIMi6Ahlt75k56EYf3hL/XxXw5mQpO4vL64GQyCBSbC8+1snKHFxa6VaGGsCVwHudmSMWoFHkhOXcpCAjXeaCb1B52fqo1BfXiDnc2NY2xGm2cY3OmW1m0mQ2uHSlW1f1zDaWQU41C4uq42zDxotWJL5Ihqr3LSOZ1aTlbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Roj3/glZ; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so4512648276.3
        for <linux-crypto@vger.kernel.org>; Mon, 03 Mar 2025 14:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741041546; x=1741646346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIfUI4hlcf8gLCPszadGslvPwfmsM1EQ3p9RC6tbM3A=;
        b=Roj3/glZV9yMxm6putR6VXmW97GoTxg2oYd/bf2PzPR+LBTcTBaYMyy0roPxrZZp9D
         8xZ+wFL3dEgKZTF7D3mXpdzqObuMIfOpMoqL9kvhXv93aahT4eDs0B8Dj5KDpgKLp/jZ
         U8N1YCT9JVn1yOs/YO2NI8D900zIa9fbmEMcJCc9F677GotWnqQqhCgjTo5v0t5uPQMQ
         MbXiGKO2PNP2DIcRl/7v3aOT17rACSCKU7PB+tatB6fc6Clt9ZGYG2HxgYw/IOaMoftl
         /0xKVFprtaWlAfVGexbQaLS1Zuu+DfjcL0Jx3Gs3GN7XDbryCcrcantqDtCfo7z+TWxU
         LP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741041546; x=1741646346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIfUI4hlcf8gLCPszadGslvPwfmsM1EQ3p9RC6tbM3A=;
        b=O0bfqX7pKCzB0hCYXMmBWta6BY1sJJ6EJ+f2r5a4aCKyaRTulKvY3iQNDV9d6aE+Wu
         z/ITrPYAma8E52vdhcjLoinNtpjqR07BV5DQi+patfnHvlx2hgr5vhzKVY8xJ7AGFPoJ
         cYwvLy88gUMZs0YMiWCpFwvT6hro4riIQGu4Y4AiFYXopmt8eRplbDduEMYWxPQpil48
         CHz/E8Az6LNRfHD18rBPI/p58bq4iF8o8Xdsag7NxSbiFZr6JF53RP/ad3jq/vGPktbK
         2vA2IAqvsTh1Q4ajhm+a3BEeW9oYM4MON80SHGnPaGfvD8BbgwKUFntSz52Pef2jIljK
         THIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgU0BuD0x1jdXDNDm6qI6nY10ktQQ9G2AvFsYDiiYfeMjGiNcPDYzZvFRzOlud6ohotYMWGQUVyw/YwX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxahYHSWmsUnMI6oqDLpafIF2JEd09NKPmyTt64KC5lgolTKZh7
	WpE5PTMFc2Jnv5PuhJMdb+c/yRA9/Md1m9K3WRpN1WqUhHpiysb6U6ew6p7gYF53Zi0zoAQtSFl
	iB2FvKOKU/pDQ/4GFx+1UOayeV11PMndD4YSW
X-Gm-Gg: ASbGnctM7GTnrMhMEzySu8gD/us32dYOZgGDCIVHFaOPnd+HZNaf4uX8htRbSgFhQS2
	qtlFwETCiVC3PH0bNLWhccmRSBtvqzCTawktAv2V9gCsT6/pFWLQ5E9WrSq24sYLufY6Oqrsh6r
	vf3mSq1NxX91Hrw69FmWe4H0+esw==
X-Google-Smtp-Source: AGHT+IFTrQyjgKJUQJ7eYo1zM033C+WFJ3GZrbEVe68n7OeEJVZzd2P3piudynky8blYHYHlCHJvvqybgCUj6AgCqZI=
X-Received: by 2002:a05:6902:218f:b0:e60:917e:c365 with SMTP id
 3f1490d57ef6-e60b2f2d8c2mr19498562276.39.1741041545724; Mon, 03 Mar 2025
 14:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com> <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com> <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com> <e0e7c0971d42e45c7b4641bd58cb7ea20b36e2e1.camel@linux.ibm.com>
In-Reply-To: <e0e7c0971d42e45c7b4641bd58cb7ea20b36e2e1.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Mar 2025 17:38:54 -0500
X-Gm-Features: AQ5f1JoyFChTTswBLTygETtKbHS_dOLZ3zWyY7fxiEUf7aKxQmqQznoJVNdyDF0
Message-ID: <CAHC9VhSzc6N0oBesT8V21xuwB11T7e6V9r0UmiqHXvCg5erkVA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:19=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Fri, 2025-02-28 at 11:14 -0500, Paul Moore wrote:
> > On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:

...

> Ok, let's go through different scenarios to see if it would scale.
>
> Scenario 1: Mostly distro signed userspace applications, minimum number o=
f
> developer, customer, 3rd party applications.
>
> Scenario 2: Multiple developer, customer, 3rd party applications, signed =
by the
> same party.
>
> Scenario 3: extreme case - every application signed by different party.
>
> With the minimum case, there would probably be a default key or sets of
> permissible keys.  In the extreme case, the number of keyrings would be
> equivalent to the number of application/software packages.

Perhaps we're not understanding each other, but my understanding of
the above three scenarios is that they are all examples of signed
applications where something (likely something in the kernel like IMA)
verifies the signature on the application.  While there are going to
be differing numbers of keys in each of the three scenarios, I believe
they would all be on/linked-to the same usage oriented keyring as they
all share the same usage: application signatures.

> > My takeaway from Clavis was that it was more about establishing a set
> > of access controls around keys already present in the keyrings and my
> > comments about usage/spplication oriented keyrings have been in that
> > context.  While the access control policy, regardless of how it is
> > implemented, should no doubt incorporate the trust placed in the
> > individual keys, how that trust is established is a separate issue
> > from access control as far as I'm concerned.
>
> Clavis defined both a mechanism for establishing trust and access control=
 rules.
>
> Clavis defined a single Clavis key to establish trust.  The Clavis policy=
 rules
> were signed by the Clavis key.  The Clavis policy rules defined the acces=
s
> control.

Unfortunately I think we're getting a little ambiguous with how we are
using the word "trust".  Just as "security" can mean different things
depending on context, so can "trust" as the qualities we are trusting
will vary depending on context.  I'll leave it at that for now as I
believe we are talking about different things in the paragraphs above.

Regardless, I'll also say this regarding Clavis and key/keyring access
controls - as implemented, Clavis doesn't look like a LSM to me for
the reasons already given.  If all of the various keys subsystem
maintainers believe it is the Right Thing To Do inside the keys
subsystem then it isn't my place to have a say in that.  I personally
believe that doing the work to support usage oriented keyrings before,
or while, implementing a Clavis-like mechanism is the better option,
but that is a decision for you and the other key maintainers.

--=20
paul-moore.com

