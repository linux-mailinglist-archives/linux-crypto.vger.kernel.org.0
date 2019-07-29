Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B379C59
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jul 2019 00:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfG2WQv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jul 2019 18:16:51 -0400
Received: from mail-eopbgr820052.outbound.protection.outlook.com ([40.107.82.52]:37796
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfG2WQv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jul 2019 18:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIdgId1n117t618XTM2Lx6ANstlphU8unrlmsR2XRknx/IYtYyw7iQ4438Am1vA4gv0RY74i2i7DUFO/WWftMpBO4rz2W6tH3ux/oZz+VPNTD601GDH06pkQzV7uNU6zCqlOQuF1EuSMoBWPbpqITHMZ8X8bHKAaShhoKn8XTfQWNs8+IYQKCDSsZyDlejc+PFLtZRkVb18f5vPCdmTmVwJf16oUfeRz2AerobHoVlbWs+4m/cIjivrkIU5cDaI9oQf1dZJo2ol7CaYL1rFR2kbXELUXz6Ps/0tkKnkKmA8wSlCMVhA+MPpqOFTnYsuyxUSOjLCakQEIjH2gvs2ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfB1ZvdaMLvlyDav8nNEgkan68ubWrnCZmRwOdSoOLU=;
 b=QTeIfg13+v68BzyGSJAFSvefy77VXUzT2rXnfUsejJw4KbrItqWqF1QFAWgtQN2U4eXz/fJklESAbkOpxXU7g+7fdcs73vZ2qnK57B7AvMzOsZMgvkCT42q8NnZznU72kREuQDI6qFN1Ssojt/fRhfcpnqMtfqv7BtR6MOsjcTwmKKMp/uhuvYuoBTYhZxELVpENPtaOwgjpYGO4btKZQYNJU0RGnFpfEasxqfCCeQHFe93hyEkE7ZGelHQNZ5xAcm0k7DAFI2JXePERRyILMD/94CnS5/EdTKOXVu8FXAQXy0r0JbM3PPZAOgB2JeFmmmDqpmwIaHVDncn7QbUPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=verimatrix.com;dmarc=pass action=none
 header.from=verimatrix.com;dkim=pass header.d=verimatrix.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verimatrix.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfB1ZvdaMLvlyDav8nNEgkan68ubWrnCZmRwOdSoOLU=;
 b=lkPjOhSjWWeEaO5+8LOtPBgu2EJcyxO048vkkZQY0sTEs5IUYJE6foT9AiyxpxFqtmNLKAtoaLLmm6xWlTpluPd6O7iukowpeQ6N/tLErHg7IPYbvrRKoU4fqBvpCRpCzrrxBtT1j40hU4DKi5hbma6imDOAQnhi/mwQjAwbt4M=
Received: from MN2PR20MB2973.namprd20.prod.outlook.com (52.132.172.146) by
 MN2PR20MB2799.namprd20.prod.outlook.com (20.178.252.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 29 Jul 2019 22:16:48 +0000
Received: from MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::d96f:39b2:19f4:c7c1]) by MN2PR20MB2973.namprd20.prod.outlook.com
 ([fe80::d96f:39b2:19f4:c7c1%7]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 22:16:48 +0000
From:   Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Pascal van Leeuwen <pascalvanl@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH] crypto: testmgr - Improve randomization of params for
 AEAD fuzz testing
Thread-Topic: [PATCH] crypto: testmgr - Improve randomization of params for
 AEAD fuzz testing
Thread-Index: AQHVQgvgfaiGsuGw40GmRhVVq3++o6bgUEIAgAD6YHCAAKUVgIAAIDgw
Date:   Mon, 29 Jul 2019 22:16:48 +0000
Message-ID: <MN2PR20MB2973C131062F1D1CABA77015CADD0@MN2PR20MB2973.namprd20.prod.outlook.com>
References: <1563960917-8236-1-git-send-email-pvanleeuwen@verimatrix.com>
 <20190728173040.GA699@sol.localdomain>
 <MN2PR20MB29737962BC74CCA790470C0BCADD0@MN2PR20MB2973.namprd20.prod.outlook.com>
 <20190729181738.GB169027@gmail.com>
In-Reply-To: <20190729181738.GB169027@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pvanleeuwen@verimatrix.com; 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1862ecfc-da89-4070-ef67-08d71472732a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR20MB2799;
x-ms-traffictypediagnostic: MN2PR20MB2799:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR20MB2799FD13B872BC6318E2945BCADD0@MN2PR20MB2799.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(39850400004)(346002)(376002)(189003)(199004)(68736007)(81156014)(81166006)(55016002)(14454004)(6436002)(6916009)(71200400001)(3846002)(71190400001)(86362001)(478600001)(8936002)(2906002)(8676002)(6116002)(25786009)(9686003)(53936002)(6246003)(102836004)(26005)(66066001)(186003)(66946007)(52536014)(76116006)(7696005)(11346002)(66556008)(446003)(14444005)(256004)(54906003)(76176011)(476003)(15974865002)(229853002)(33656002)(486006)(6506007)(74316002)(99286004)(4326008)(7736002)(30864003)(5660300002)(316002)(66446008)(305945005)(66476007)(64756008)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR20MB2799;H:MN2PR20MB2973.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: verimatrix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MZt48Tppnjs89w5YnmqstuHLV2uovoYkD9QgNAbuwCaUdUokAvb8WMAfcfRU4GrwICB8m4rAuykXRv2QfAWfeR7JrBvaVy6uwUr1FEDEjuR/MrITf8RFQdkj0NhrV8MTtmY+6uAhAtkg2lOzPSrMCzaQ1ruB95d9ozkEqy5HizT47yszlQyTFTMvsLV2TJ40UiGVC5mY0AorUV9aDTZFeZYcPg74wV9uQlQ1gE37ZVCRAx+BUWVP0qkP2w140XHaXTEOON9B/gMZ42e9HWoJfrCEqw7YXB2H5/1iQw5NOmeB8Gnpul5eUK8xbLCwy8xQXlsIinHJJGpYpLI2tyI/xlBlYUoNExc6G0Lybdb7/h1c9NQQD7Mfko+tKwqC1Trm4j1iupwWCWk8D8dvwZe37vqzQkQ+UdOL6NstChrw7fA=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: verimatrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1862ecfc-da89-4070-ef67-08d71472732a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 22:16:48.4097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dcb260f9-022d-4495-8602-eae51035a0d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvanleeuwen@verimatrix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB2799
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

> > Interesting as the inside-secure driver also advertises this ciphersuit=
e and does not
> generate such
> > an error.  My guess is you get an error here because plen is not a mult=
iple of 16 and this
> is CBC
> > (note to self: for block ciphers, emphasize legal lengths in the random=
ization ...), but
> the generic
> > implementation returns -EINVAL while this ciphersuite returns -EBADMSG.
> > Don't ask me what the actual correct error is in this case, I'm followi=
ng generic with my
> driver.
>=20
> EINVAL is for invalid lengths while EBADMSG is for inauthentic inputs.
> Inauthentic test vectors aren't yet automatically generated (even after t=
his
> patch), so I don't think EBADMSG should be seen here.  Are you sure there=
 isn't
> a bug in your patch that's causing this?
>=20
As far as I understand it, the output of the encryption is fed back in to
decrypt. However, if the encryption didn't work due to blocksize mismatch,=
=20
there would not be any valid encrypted and authenticated data written out.=
=20
So, if the (generic) driver checks that for decryption, it would result in
-EINVAL. If it wouldn't check that, it would try to decrypt and authentica
te the data, which would almost certainly result in a tag mismatch and
thus an -EBADMSG error being reported.

So actually, the witnessed issue can be perfectly explained from a missing
block size check in aesni.

> Regardless, something needs to be done about this test failure.  Generall=
y, when
> improving the tests I've sent out any needed fixes for the generic, x86, =
arm,
> and arm64 software crypto algorithms first, since those are the most comm=
only
> used and the easiest for most people to test.
>=20
Well, first off, I'm running with the inside-secure driver installed, so I
actually don't see any fuzz results for any other implementations. I=20
really don't have the time, tools, hardware, setup or skills to run all
kinds of different kernel configs and debug any failures that may occur
with any configuration and/or driver.  I'm not a  SW engineer and this=20
is not my dayjob. It is not even a hobby as don't enjoy it very much.
So I will depend on the rest of the community to help out there.

> > > Note that the "empty test suite" message shouldn't be printed (especi=
ally not at
> > > KERN_ERR level!) if it's working as intended.
> > >
> > That's not my code, that was already there. I already got these message=
s before my
> > modifications, for some ciphersuites. Of course if we don't want that, =
we can make
> > it a pr_warn pr_dbg?
>=20
> I didn't get these error messages before this patch.  They start showing =
up
> because this patch changes alg_test_null to alg_test_aead for algorithms =
with no
> test vectors.
>
Ok, I guess I caused it for some additional ciphersuites by forcing them
to be at least fuzz tested. But there were some ciphersuites without test
vectors already reporting this in my situation because they did not point
to alg_test_null in the first place. So it wasn't entirely clear what the
whole intention was in the first place, as it wasn't consistent.
If we all agree on the logging level we want for this message, then I can
make that change.

> > > Why not put these new fields in the existing 'struct aead_test_suite'=
?
> > >
> > > I don't see the point of the separate 'params' struct.  It just confu=
ses things.
> > >
> > Mostly because I'm not that familiar with C datastructures (I'm not a p=
rogrammer
> > and this is pretty much my first serious experience with C), so I didn'=
t know how
> > to do that / didn't want to break anything else :-)
> >
> > So if you can provide some example on how to do that ...
>=20
> I'm simply suggesting adding the fields of 'struct aead_test_params' to
> 'struct aead_test_suite'.
>=20
My next mail tried to explain why that's not so simple ...

> > > > +	alen =3D random_lensel(&lengths->akeylensel);
> > > > +	clen =3D random_lensel(&lengths->ckeylensel);
> > > > +	if ((alen >=3D 0) && (clen >=3D 0)) {
> > > > +		/* Corect blob header. TBD: Do we care about corrupting this? */
> > > > +#ifdef __LITTLE_ENDIAN
> > > > +		memcpy((void *)vec->key, "\x08\x00\x01\x00\x00\x00\x00\x10", 8);
> > > > +#else
> > > > +		memcpy((void *)vec->key, "\x00\x08\x00\x01\x00\x00\x00\x10", 8);
> > > > +#endif
> > >
> > > Isn't this specific to "authenc" AEADs?  There needs to be something =
in the test
> > > suite that says an authenc formatted key is needed.
> > >
> > It's under the condition of seperate authentication (alen) and cipher (=
clen) keys,
> > true AEAD's only have a single key. Because if they hadn't, they would =
also need
> > this kind of key blob thing (at least for consistency) and need this co=
de.
> >
> > > > +
> > > > +		/* Generate keys based on length templates */
> > > > +		generate_random_bytes((u8 *)(vec->key + 8), alen);
> > > > +		generate_random_bytes((u8 *)(vec->key + 8 + alen),
> > > > +				      clen);
> > > > +
> > > > +		vec->klen =3D 8 + alen + clen;
> > > > +	} else {
> > > > +		if (clen >=3D 0)
> > > > +			maxkeysize =3D clen;
> > > > +
> > > > +		vec->klen =3D maxkeysize;
> > > > +
> > > > +		/*
> > > > +		 * Key: length in [0, maxkeysize],
> > > > +		 * but usually choose maxkeysize
> > > > +		 */
> > > > +		if (prandom_u32() % 4 =3D=3D 0)
> > > > +			vec->klen =3D prandom_u32() % (maxkeysize + 1);
> > > > +		generate_random_bytes((u8 *)vec->key, vec->klen);
> > > > +	}
>=20
> Sure, but why is this patch making the length selectors specific to AEADs=
 that
> use separate authentication and encryption keys?  It should work for both=
.
>=20
Actually, the patch *should* (didn't try yet) make it work for both: if bot=
h
alen and clen are valid (>=3D0) then it creates a key blob from those range=
s.=20
If only clen is valid (>=3D0) but a alen is not (i.e., -1), then it will ju=
st
generate a random key the "normal" way with length clen.
So, for authenc you define both ranges, for other AEAD you define only a
cipher key length range with the auth key range count at 0.

> > > >  	vec->setkey_error =3D crypto_aead_setkey(tfm, vec->key, vec->klen=
);
> > >
> > > The generate_random_aead_testvec() function is getting too long and c=
omplicated.
> > >
> > I'll ignore that comment to avoid starting some flame war ;-)
> >
> > > It doesn't help that now the 'clen' variable is used for multiple dif=
ferent
> > > purposes (encryption key length and ciphertext length).
> > >
> > Ah yeah, actually I had seperate variables for that which I at some poi=
nt merged to
> > save some stack space. Blame it on me being oldschool ;-)
> >
> > > Could you maybe factor out the key generation into a separate functio=
n?
> > >
> > I could, if that would make people happy ...
>=20
> Not sure why anyone would start a flame war.  This is just usual software
> development: functions often get too long and complicated as people keep
> patching in more stuff, so periodically there needs to be some refactorin=
g to
> keep the code understandable/maintainable/reviewable. =20
>
That's an opinion I don't share. And I was trying not to go there :-)
So to avoid any useless discussion, I will just do it.

> And I strongly believe that contributors to the problem need to
> be responsible for doing their part, and not assume that Someone
> Else will do it :-)
>=20
Fair enough, although this large community should provide opportunity
for others to help out a bit here and there ... especially when it
comes to trivial & non-essential improvements that anyone could do.
(I don't really have a whole lot of time I can spend on this, so I'd
rather focus on the concept rather than the implementation details)

> > > > +
> > > > +/*
> > > > + * List of length ranges sorted on increasing threshold
> > > > + *
> > > > + * 25% of each of the legal key sizes (128, 192, 256 bits)
> > > > + * plus 25% of illegal sizes in between 0 and 1024 bits.
> > > > + */
> > > > +static const struct len_range_sel aes_klen_template[] =3D {
> > > > +	{
> > > > +	.len_lo =3D 0,
> > > > +	.len_hi =3D 15,
> > > > +	.threshold =3D 25,
> > > > +	}, {
> > > > +	.len_lo =3D 16,
> > > > +	.len_hi =3D 16,
> > > > +	.threshold =3D 325,
> > > > +	}, {
> > > > +	.len_lo =3D 17,
> > > > +	.len_hi =3D 23,
> > > > +	.threshold =3D 350,
> > > > +	}, {
> > > > +	.len_lo =3D 24,
> > > > +	.len_hi =3D 24,
> > > > +	.threshold =3D 650,
> > > > +	}, {
> > > > +	.len_lo =3D 25,
> > > > +	.len_hi =3D 31,
> > > > +	.threshold =3D 675,
> > > > +	}, {
> > > > +	.len_lo =3D 32,
> > > > +	.len_hi =3D 32,
> > > > +	.threshold =3D 975,
> > > > +	}, {
> > > > +	.len_lo =3D 33,
> > > > +	.len_hi =3D 128,
> > > > +	.threshold =3D 1000,
> > > > +	}
> > > > +};
> > >
> > > Can you please move these to be next to the test vectors for each alg=
orithm, so
> > > things are kept in one place for each algorithm?
> > >
> > Actually, these are supposed to be generic, to be shared across multipl=
e
> > test vectors. So what do you think would be the best place for them?
>=20
> These are specific to AES, though.  So I'd expect to find them next to th=
e plain
> AES test vectors (aes_tv_template[]).
>
Ah yes, that would indeed be a better place, thanks!
=20
> >
> > > Also, perhaps these should use the convention '.proportion_of_total',=
 like
> > > 'struct testvec_config' already does, rather than '.threshold'?  That=
 would be
> > > more consistent with the existing test code, and would also make it s=
lightly
> > > easier to change the probabilities later.
> > >
> > I'm not quite sure if its the same thing. If someone can acknowledge th=
at it is,
> > I could give it the same name. But otherwise, that would just be confus=
ing ...
> >
> > > E.g. if someone wanted to increase the probability of the first case =
and
> > > decrease the probability of the last case, then with the '.threshold'=
 convention
> > > they'd have to change for every entry, but with the '.proportion_of_t=
otal'
> > > convention they'd only have to change the first and last entries.
> > >
> > Oh, you are suggesting to change the whole mechanism, not just the name=
.
> > Honestly, I didn't like the proportion_of_total mechanism because it
> > requires you to parse the data twice. Again, I'm oldschool so I try to =
provide
> > my data in such a form that it requires the least amount of actual proc=
essing.
> >
>=20
> It would be the same number of passes.  One for each the actual generatio=
n, and
> one in testmgr_onetime_init() to verify the numbers add up to exactly 100=
%.
>
Never mind, I think I had the wrong idea on how proportion_of_total worked,
they would indeed need the same number of passes. I guess the threshold=20
approach is due to my HW background, reducing computation at all cost, whil=
e
the proportion of total approach may be easier for maintaining the tables.

I can change to that mechanism instead.

> (A verification pass would still be needed in the '.threshold' convention=
 too,
> to verify that the numbers are all < 100% and in increasing order.)
>=20

> I'd rather optimize for making it easy to write and change the test vecto=
rs,
> since those are much more lines of code than the .c code that runs the te=
sts.
>=20
Yeah, I figured as much. It is not natural for me to worry about these thin=
gs.


> Thanks!
>=20
> - Eric

Regards,
Pascal van Leeuwen
Silicon IP Architect, Multi-Protocol Engines @ Verimatrix
www.insidesecure.com
