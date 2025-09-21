
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 24 64 00 00       	push   $0x6424
      16:	6a 01                	push   $0x1
      18:	e8 93 42 00 00       	call   42b0 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 38 64 00 00       	push   $0x6438
      26:	e8 48 41 00 00       	call   4173 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 14 53 00 00       	push   $0x5314
      39:	6a 01                	push   $0x1
      3b:	e8 70 42 00 00       	call   42b0 <printf>
    exit();
      40:	e8 ee 40 00 00       	call   4133 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 38 64 00 00       	push   $0x6438
      51:	e8 1d 41 00 00       	call   4173 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 fd 40 00 00       	call   415b <close>

  shmgetTest();
      5e:	e8 cd 00 00 00       	call   130 <shmgetTest>
  shmctlTest();
      63:	e8 88 03 00 00       	call   3f0 <shmctlTest>
  shmatTest();
      68:	e8 13 05 00 00       	call   580 <shmatTest>
  shmdtTest();
      6d:	e8 ee 06 00 00       	call   760 <shmdtTest>
  test_read_and_write_simple();          
      72:	e8 d9 07 00 00       	call   850 <test_read_and_write_simple>
  // test_read_and_write_advanced();       // Due to size limitation cannot run all read and write tests simultaneously
  // test_read_and_write_multiprocess();   // Due to size limitation cannot run all read and write tests simultaneously

  argptest();
      77:	e8 e4 3d 00 00       	call   3e60 <argptest>
  createdelete();
      7c:	e8 0f 1a 00 00       	call   1a90 <createdelete>
  linkunlink();
      81:	e8 aa 22 00 00       	call   2330 <linkunlink>
  concreate();
      86:	e8 a5 1f 00 00       	call   2030 <concreate>
  fourfiles();
      8b:	e8 00 18 00 00       	call   1890 <fourfiles>
  sharedfd();
      90:	e8 3b 16 00 00       	call   16d0 <sharedfd>

  bigargtest();
      95:	e8 66 3a 00 00       	call   3b00 <bigargtest>
  bigwrite();
      9a:	e8 b1 2b 00 00       	call   2c50 <bigwrite>
  bigargtest();
      9f:	e8 5c 3a 00 00       	call   3b00 <bigargtest>
  bsstest();
      a4:	e8 e7 39 00 00       	call   3a90 <bsstest>
  sbrktest();
      a9:	e8 e2 34 00 00       	call   3590 <sbrktest>
  validatetest();
      ae:	e8 2d 39 00 00       	call   39e0 <validatetest>

  opentest();
      b3:	e8 a8 0b 00 00       	call   c60 <opentest>
  writetest();
      b8:	e8 33 0c 00 00       	call   cf0 <writetest>
  writetest1();
      bd:	e8 0e 0e 00 00       	call   ed0 <writetest1>
  createtest();
      c2:	e8 d9 0f 00 00       	call   10a0 <createtest>

  openiputtest();
      c7:	e8 94 0a 00 00       	call   b60 <openiputtest>
  exitiputtest();
      cc:	e8 8f 09 00 00       	call   a60 <exitiputtest>
  iputtest();
      d1:	e8 aa 08 00 00       	call   980 <iputtest>

  mem();
      d6:	e8 25 15 00 00       	call   1600 <mem>
  pipe1();
      db:	e8 a0 11 00 00       	call   1280 <pipe1>
  preempt();
      e0:	e8 3b 13 00 00       	call   1420 <preempt>
  exitwait();
      e5:	e8 96 14 00 00       	call   1580 <exitwait>

  rmdot();
      ea:	e8 51 2f 00 00       	call   3040 <rmdot>
  fourteen();
      ef:	e8 0c 2e 00 00       	call   2f00 <fourteen>
  bigfile();
      f4:	e8 37 2c 00 00       	call   2d30 <bigfile>
  subdir();
      f9:	e8 72 24 00 00       	call   2570 <subdir>
  linktest();
      fe:	e8 1d 1d 00 00       	call   1e20 <linktest>
  unlinkread();
     103:	e8 88 1b 00 00       	call   1c90 <unlinkread>
  dirfile();
     108:	e8 b3 30 00 00       	call   31c0 <dirfile>
  iref();
     10d:	e8 ae 32 00 00       	call   33c0 <iref>
  forktest();
     112:	e8 c9 33 00 00       	call   34e0 <forktest>
  bigdir(); // slow
     117:	e8 24 23 00 00       	call   2440 <bigdir>

  uio();
     11c:	e8 cf 3c 00 00       	call   3df0 <uio>

  exectest();
     121:	e8 0a 11 00 00       	call   1230 <exectest>

  exit();
     126:	e8 08 40 00 00       	call   4133 <exit>
     12b:	66 90                	xchg   %ax,%ax
     12d:	66 90                	xchg   %ax,%ax
     12f:	90                   	nop

00000130 <shmgetTest>:
void shmgetTest(){
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	53                   	push   %ebx
     134:	83 ec 1c             	sub    $0x1c,%esp
	printf(1, "\n--------------SHMGET TEST--------------\n\n");
     137:	68 b8 45 00 00       	push   $0x45b8
     13c:	6a 01                	push   $0x1
     13e:	e8 6d 41 00 00       	call   42b0 <printf>
	printf(1, "creating a segment with IPC_CREAT: ");
     143:	5b                   	pop    %ebx
     144:	58                   	pop    %eax
     145:	68 e4 45 00 00       	push   $0x45e4
     14a:	6a 01                	push   $0x1
     14c:	e8 5f 41 00 00       	call   42b0 <printf>
	shmid = shmget(12345, 2000, IPC_CREAT);
     151:	83 c4 0c             	add    $0xc,%esp
     154:	6a 04                	push   $0x4
     156:	68 d0 07 00 00       	push   $0x7d0
     15b:	68 39 30 00 00       	push   $0x3039
     160:	e8 6e 40 00 00       	call   41d3 <shmget>
	if(shmid < 0){
     165:	83 c4 10             	add    $0x10,%esp
     168:	85 c0                	test   %eax,%eax
     16a:	0f 88 67 02 00 00    	js     3d7 <shmgetTest+0x2a7>
  printf(1, "Passed\n");
     170:	83 ec 08             	sub    $0x8,%esp
     173:	89 c3                	mov    %eax,%ebx
     175:	68 3e 53 00 00       	push   $0x533e
     17a:	6a 01                	push   $0x1
     17c:	e8 2f 41 00 00       	call   42b0 <printf>
  printf(1, "created segment with id: %d\n", shmid);
     181:	83 c4 0c             	add    $0xc,%esp
     184:	53                   	push   %ebx
     185:	68 46 53 00 00       	push   $0x5346
     18a:	6a 01                	push   $0x1
     18c:	e8 1f 41 00 00       	call   42b0 <printf>
  printf(1, "creating a segment with IPC_CREAT | IPC_EXCL (with new key, should create new segment pass the test): ");
     191:	58                   	pop    %eax
     192:	5a                   	pop    %edx
     193:	68 08 46 00 00       	push   $0x4608
     198:	6a 01                	push   $0x1
     19a:	e8 11 41 00 00       	call   42b0 <printf>
	shmid = shmget(12346, 1024, IPC_CREAT | IPC_EXCL);
     19f:	83 c4 0c             	add    $0xc,%esp
     1a2:	6a 14                	push   $0x14
     1a4:	68 00 04 00 00       	push   $0x400
     1a9:	68 3a 30 00 00       	push   $0x303a
     1ae:	e8 20 40 00 00       	call   41d3 <shmget>
	if(shmid < 0){
     1b3:	83 c4 10             	add    $0x10,%esp
	shmid = shmget(12346, 1024, IPC_CREAT | IPC_EXCL);
     1b6:	89 c3                	mov    %eax,%ebx
	if(shmid < 0){
     1b8:	85 c0                	test   %eax,%eax
     1ba:	0f 88 04 02 00 00    	js     3c4 <shmgetTest+0x294>
  printf(1, "Passed\n");
     1c0:	83 ec 08             	sub    $0x8,%esp
     1c3:	68 3e 53 00 00       	push   $0x533e
     1c8:	6a 01                	push   $0x1
     1ca:	e8 e1 40 00 00       	call   42b0 <printf>
  printf(1, "created segment with id: %d\n", shmid);
     1cf:	83 c4 0c             	add    $0xc,%esp
     1d2:	53                   	push   %ebx
     1d3:	68 46 53 00 00       	push   $0x5346
     1d8:	6a 01                	push   $0x1
     1da:	e8 d1 40 00 00       	call   42b0 <printf>
  printf(1, "creating a segment with IPC_CREAT | IPC_EXCL (with used key, should not create to pass the test): ");
     1df:	59                   	pop    %ecx
     1e0:	5b                   	pop    %ebx
     1e1:	68 70 46 00 00       	push   $0x4670
     1e6:	6a 01                	push   $0x1
     1e8:	e8 c3 40 00 00       	call   42b0 <printf>
	shmid = shmget(12346, 1024, IPC_CREAT | IPC_EXCL);
     1ed:	83 c4 0c             	add    $0xc,%esp
     1f0:	6a 14                	push   $0x14
     1f2:	68 00 04 00 00       	push   $0x400
     1f7:	68 3a 30 00 00       	push   $0x303a
     1fc:	e8 d2 3f 00 00       	call   41d3 <shmget>
	if(shmid >= 0){
     201:	83 c4 10             	add    $0x10,%esp
     204:	85 c0                	test   %eax,%eax
     206:	0f 89 8e 01 00 00    	jns    39a <shmgetTest+0x26a>
  printf(1, "Passed\n");
     20c:	83 ec 08             	sub    $0x8,%esp
     20f:	68 3e 53 00 00       	push   $0x533e
     214:	6a 01                	push   $0x1
     216:	e8 95 40 00 00       	call   42b0 <printf>
  printf(1, "creating a segment with no flag (should return old segment if key is already used): ");
     21b:	58                   	pop    %eax
     21c:	5a                   	pop    %edx
     21d:	68 d4 46 00 00       	push   $0x46d4
     222:	6a 01                	push   $0x1
     224:	e8 87 40 00 00       	call   42b0 <printf>
	shmid = shmget(12345, 1024, 0);
     229:	83 c4 0c             	add    $0xc,%esp
     22c:	6a 00                	push   $0x0
     22e:	68 00 04 00 00       	push   $0x400
     233:	68 39 30 00 00       	push   $0x3039
     238:	e8 96 3f 00 00       	call   41d3 <shmget>
	if(shmid < 0){
     23d:	83 c4 10             	add    $0x10,%esp
	shmid = shmget(12345, 1024, 0);
     240:	89 c3                	mov    %eax,%ebx
	if(shmid < 0){
     242:	85 c0                	test   %eax,%eax
     244:	0f 88 7a 01 00 00    	js     3c4 <shmgetTest+0x294>
  printf(1, "Passed\n");
     24a:	83 ec 08             	sub    $0x8,%esp
     24d:	68 3e 53 00 00       	push   $0x533e
     252:	6a 01                	push   $0x1
     254:	e8 57 40 00 00       	call   42b0 <printf>
  printf(1, "returned segment with id: %d\n", shmid);
     259:	83 c4 0c             	add    $0xc,%esp
     25c:	53                   	push   %ebx
     25d:	68 6b 53 00 00       	push   $0x536b
     262:	6a 01                	push   $0x1
     264:	e8 47 40 00 00       	call   42b0 <printf>
  printf(1, "creating a segment with no flag (should not create a new segment if key is new): ");
     269:	59                   	pop    %ecx
     26a:	5b                   	pop    %ebx
     26b:	68 2c 47 00 00       	push   $0x472c
     270:	6a 01                	push   $0x1
     272:	e8 39 40 00 00       	call   42b0 <printf>
	shmid = shmget(12347, 1024, 0);
     277:	83 c4 0c             	add    $0xc,%esp
     27a:	6a 00                	push   $0x0
     27c:	68 00 04 00 00       	push   $0x400
     281:	68 3b 30 00 00       	push   $0x303b
     286:	e8 48 3f 00 00       	call   41d3 <shmget>
	if(shmid >= 0){
     28b:	83 c4 10             	add    $0x10,%esp
     28e:	85 c0                	test   %eax,%eax
     290:	0f 89 04 01 00 00    	jns    39a <shmgetTest+0x26a>
  printf(1, "Passed\n");
     296:	83 ec 08             	sub    $0x8,%esp
     299:	68 3e 53 00 00       	push   $0x533e
     29e:	6a 01                	push   $0x1
     2a0:	e8 0b 40 00 00       	call   42b0 <printf>
  printf(1, "creating a segment with IPC_PRIVATE (should create new segment with randomly generated key to pass the test): ");
     2a5:	58                   	pop    %eax
     2a6:	5a                   	pop    %edx
     2a7:	68 80 47 00 00       	push   $0x4780
     2ac:	6a 01                	push   $0x1
     2ae:	e8 fd 3f 00 00       	call   42b0 <printf>
	shmid = shmget(IPC_PRIVATE, 1024, IPC_CREAT | IPC_EXCL);
     2b3:	83 c4 0c             	add    $0xc,%esp
     2b6:	6a 14                	push   $0x14
     2b8:	68 00 04 00 00       	push   $0x400
     2bd:	68 61 79 fe ff       	push   $0xfffe7961
     2c2:	e8 0c 3f 00 00       	call   41d3 <shmget>
	if(shmid < 0){
     2c7:	83 c4 10             	add    $0x10,%esp
	shmid = shmget(IPC_PRIVATE, 1024, IPC_CREAT | IPC_EXCL);
     2ca:	89 c3                	mov    %eax,%ebx
	if(shmid < 0){
     2cc:	85 c0                	test   %eax,%eax
     2ce:	0f 88 03 01 00 00    	js     3d7 <shmgetTest+0x2a7>
  printf(1, "Passed\n");
     2d4:	83 ec 08             	sub    $0x8,%esp
     2d7:	68 3e 53 00 00       	push   $0x533e
     2dc:	6a 01                	push   $0x1
     2de:	e8 cd 3f 00 00       	call   42b0 <printf>
  printf(1, "created segment with id: %d\n", shmid);
     2e3:	83 c4 0c             	add    $0xc,%esp
     2e6:	53                   	push   %ebx
     2e7:	68 46 53 00 00       	push   $0x5346
     2ec:	6a 01                	push   $0x1
     2ee:	e8 bd 3f 00 00       	call   42b0 <printf>
  printf(1, "creating a segment of size less than minimum size of segment i.e. 1024bytes: ");
     2f3:	59                   	pop    %ecx
     2f4:	5b                   	pop    %ebx
     2f5:	68 f0 47 00 00       	push   $0x47f0
     2fa:	6a 01                	push   $0x1
     2fc:	e8 af 3f 00 00       	call   42b0 <printf>
	shmid = shmget(IPC_PRIVATE, 512, IPC_CREAT | IPC_EXCL);
     301:	83 c4 0c             	add    $0xc,%esp
     304:	6a 14                	push   $0x14
     306:	68 00 02 00 00       	push   $0x200
     30b:	68 61 79 fe ff       	push   $0xfffe7961
     310:	e8 be 3e 00 00       	call   41d3 <shmget>
	if(shmid >= 0){
     315:	83 c4 10             	add    $0x10,%esp
     318:	85 c0                	test   %eax,%eax
     31a:	79 7e                	jns    39a <shmgetTest+0x26a>
  printf(1, "Passed\n");
     31c:	83 ec 08             	sub    $0x8,%esp
     31f:	68 3e 53 00 00       	push   $0x533e
     324:	6a 01                	push   $0x1
     326:	e8 85 3f 00 00       	call   42b0 <printf>
  printf(1, "creating a segment of size greater than maximum possible size of segment i.e. 16mb: ");
     32b:	58                   	pop    %eax
     32c:	5a                   	pop    %edx
     32d:	68 40 48 00 00       	push   $0x4840
     332:	6a 01                	push   $0x1
     334:	e8 77 3f 00 00       	call   42b0 <printf>
	shmid = shmget(IPC_PRIVATE, (16*1024*1024), IPC_CREAT | IPC_EXCL);
     339:	83 c4 0c             	add    $0xc,%esp
     33c:	6a 14                	push   $0x14
     33e:	68 00 00 00 01       	push   $0x1000000
     343:	68 61 79 fe ff       	push   $0xfffe7961
     348:	e8 86 3e 00 00       	call   41d3 <shmget>
	if(shmid >= 0){
     34d:	83 c4 10             	add    $0x10,%esp
     350:	85 c0                	test   %eax,%eax
     352:	79 46                	jns    39a <shmgetTest+0x26a>
  printf(1, "Passed\n");
     354:	83 ec 08             	sub    $0x8,%esp
     357:	68 3e 53 00 00       	push   $0x533e
     35c:	6a 01                	push   $0x1
     35e:	e8 4d 3f 00 00       	call   42b0 <printf>
  removeshm(0, 0);
     363:	58                   	pop    %eax
     364:	5a                   	pop    %edx
     365:	6a 00                	push   $0x0
     367:	6a 00                	push   $0x0
     369:	e8 8d 3e 00 00       	call   41fb <removeshm>
  removeshm(1, 0);
     36e:	59                   	pop    %ecx
     36f:	5b                   	pop    %ebx
     370:	6a 00                	push   $0x0
     372:	6a 01                	push   $0x1
     374:	e8 82 3e 00 00       	call   41fb <removeshm>
  removeshm(2, 0);
     379:	58                   	pop    %eax
     37a:	5a                   	pop    %edx
     37b:	6a 00                	push   $0x0
     37d:	6a 02                	push   $0x2
     37f:	e8 77 3e 00 00       	call   41fb <removeshm>
  printf(1, "\n----------SHMGET TEST PASSED!----------\n\n");
     384:	59                   	pop    %ecx
     385:	5b                   	pop    %ebx
     386:	68 98 48 00 00       	push   $0x4898
     38b:	6a 01                	push   $0x1
     38d:	e8 1e 3f 00 00       	call   42b0 <printf>
}
     392:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     395:	83 c4 10             	add    $0x10,%esp
     398:	c9                   	leave
     399:	c3                   	ret
		printf(1, "Failed\n");
     39a:	83 ec 08             	sub    $0x8,%esp
     39d:	89 45 f4             	mov    %eax,-0xc(%ebp)
     3a0:	68 63 53 00 00       	push   $0x5363
     3a5:	6a 01                	push   $0x1
     3a7:	e8 04 3f 00 00       	call   42b0 <printf>
    printf(1, "created segment with id: %d\n", shmid);
     3ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3af:	83 c4 0c             	add    $0xc,%esp
     3b2:	50                   	push   %eax
     3b3:	68 46 53 00 00       	push   $0x5346
     3b8:	6a 01                	push   $0x1
     3ba:	e8 f1 3e 00 00       	call   42b0 <printf>
    exit();
     3bf:	e8 6f 3d 00 00       	call   4133 <exit>
		printf(1, "Failed\n");
     3c4:	50                   	push   %eax
     3c5:	50                   	push   %eax
     3c6:	68 63 53 00 00       	push   $0x5363
     3cb:	6a 01                	push   $0x1
     3cd:	e8 de 3e 00 00       	call   42b0 <printf>
    exit();
     3d2:	e8 5c 3d 00 00       	call   4133 <exit>
		printf(1, "failed\n");
     3d7:	51                   	push   %ecx
     3d8:	51                   	push   %ecx
     3d9:	68 76 57 00 00       	push   $0x5776
     3de:	6a 01                	push   $0x1
     3e0:	e8 cb 3e 00 00       	call   42b0 <printf>
    exit();
     3e5:	e8 49 3d 00 00       	call   4133 <exit>
     3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <shmctlTest>:
void shmctlTest(){
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	57                   	push   %edi
     3f4:	56                   	push   %esi
     3f5:	53                   	push   %ebx
     3f6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "\n--------------SHMCTL TEST--------------\n\n");
     3f9:	68 c4 48 00 00       	push   $0x48c4
     3fe:	6a 01                	push   $0x1
     400:	e8 ab 3e 00 00       	call   42b0 <printf>
	int shmid = shmget(IPC_PRIVATE, 1024, IPC_CREAT );
     405:	83 c4 0c             	add    $0xc,%esp
     408:	6a 04                	push   $0x4
     40a:	68 00 04 00 00       	push   $0x400
     40f:	68 61 79 fe ff       	push   $0xfffe7961
     414:	e8 ba 3d 00 00       	call   41d3 <shmget>
  printf(1, "Calling shmctl with cmd=IPC_INFO:  ");
     419:	59                   	pop    %ecx
     41a:	5e                   	pop    %esi
     41b:	68 f0 48 00 00       	push   $0x48f0
     420:	6a 01                	push   $0x1
	int shmid = shmget(IPC_PRIVATE, 1024, IPC_CREAT );
     422:	89 c3                	mov    %eax,%ebx
  printf(1, "Calling shmctl with cmd=IPC_INFO:  ");
     424:	e8 87 3e 00 00       	call   42b0 <printf>
  shmctl(shmid, IPC_INFO, 0);
     429:	83 c4 0c             	add    $0xc,%esp
     42c:	6a 00                	push   $0x0
     42e:	6a 04                	push   $0x4
     430:	53                   	push   %ebx
     431:	e8 b5 3d 00 00       	call   41eb <shmctl>
  printf(1, "Passed\n");
     436:	5f                   	pop    %edi
     437:	58                   	pop    %eax
     438:	68 3e 53 00 00       	push   $0x533e
     43d:	6a 01                	push   $0x1
     43f:	e8 6c 3e 00 00       	call   42b0 <printf>
  printf(1, "Calling shmctl with cmd=SHM_INFO:  ");
     444:	58                   	pop    %eax
     445:	5a                   	pop    %edx
     446:	68 14 49 00 00       	push   $0x4914
     44b:	6a 01                	push   $0x1
     44d:	e8 5e 3e 00 00       	call   42b0 <printf>
  shmctl(shmid, SHM_INFO, 0);
     452:	83 c4 0c             	add    $0xc,%esp
     455:	6a 00                	push   $0x0
     457:	6a 05                	push   $0x5
     459:	53                   	push   %ebx
     45a:	e8 8c 3d 00 00       	call   41eb <shmctl>
  printf(1, "Passed\n");
     45f:	59                   	pop    %ecx
     460:	5e                   	pop    %esi
     461:	68 3e 53 00 00       	push   $0x533e
     466:	6a 01                	push   $0x1
     468:	e8 43 3e 00 00       	call   42b0 <printf>
  printf(1, "Calling shmctl with cmd=IPC_STAT:  ");
     46d:	5f                   	pop    %edi
     46e:	58                   	pop    %eax
     46f:	68 38 49 00 00       	push   $0x4938
     474:	6a 01                	push   $0x1
     476:	e8 35 3e 00 00       	call   42b0 <printf>
  struct shmid_ds *buf = (struct shmid_ds*)malloc(sizeof(struct shmid_ds));
     47b:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
     482:	e8 49 40 00 00       	call   44d0 <malloc>
  int ret = shmctl(shmid, IPC_STAT, buf);
     487:	83 c4 0c             	add    $0xc,%esp
     48a:	50                   	push   %eax
  struct shmid_ds *buf = (struct shmid_ds*)malloc(sizeof(struct shmid_ds));
     48b:	89 c6                	mov    %eax,%esi
  int ret = shmctl(shmid, IPC_STAT, buf);
     48d:	6a 01                	push   $0x1
     48f:	53                   	push   %ebx
     490:	e8 56 3d 00 00       	call   41eb <shmctl>
  if(ret < 0){
     495:	83 c4 10             	add    $0x10,%esp
     498:	85 c0                	test   %eax,%eax
     49a:	0f 88 c8 00 00 00    	js     568 <shmctlTest+0x178>
  printf(1, "Passed\n");
     4a0:	83 ec 08             	sub    $0x8,%esp
     4a3:	68 3e 53 00 00       	push   $0x533e
     4a8:	6a 01                	push   $0x1
     4aa:	e8 01 3e 00 00       	call   42b0 <printf>
  printf(1, "Calling shmctl with cmd=IPC_SET:  ");
     4af:	58                   	pop    %eax
     4b0:	5a                   	pop    %edx
     4b1:	68 5c 49 00 00       	push   $0x495c
     4b6:	6a 01                	push   $0x1
     4b8:	e8 f3 3d 00 00       	call   42b0 <printf>
  shmctl(shmid, IPC_SET, buf);
     4bd:	83 c4 0c             	add    $0xc,%esp
  buf->shm_perm.mode = 0777;
     4c0:	c7 46 04 ff 01 00 00 	movl   $0x1ff,0x4(%esi)
  shmctl(shmid, IPC_SET, buf);
     4c7:	56                   	push   %esi
     4c8:	6a 02                	push   $0x2
     4ca:	53                   	push   %ebx
     4cb:	e8 1b 3d 00 00       	call   41eb <shmctl>
  struct shmid_ds *buf1 = (struct shmid_ds*)malloc(sizeof(struct shmid_ds));
     4d0:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
     4d7:	e8 f4 3f 00 00       	call   44d0 <malloc>
  shmctl(shmid, IPC_STAT, buf1);
     4dc:	83 c4 0c             	add    $0xc,%esp
     4df:	50                   	push   %eax
  struct shmid_ds *buf1 = (struct shmid_ds*)malloc(sizeof(struct shmid_ds));
     4e0:	89 c7                	mov    %eax,%edi
  shmctl(shmid, IPC_STAT, buf1);
     4e2:	6a 01                	push   $0x1
     4e4:	53                   	push   %ebx
     4e5:	e8 01 3d 00 00       	call   41eb <shmctl>
  if(buf1->shm_perm.mode != 0777){
     4ea:	83 c4 10             	add    $0x10,%esp
     4ed:	81 7f 04 ff 01 00 00 	cmpl   $0x1ff,0x4(%edi)
     4f4:	75 72                	jne    568 <shmctlTest+0x178>
  printf(1, "Passed\n");
     4f6:	83 ec 08             	sub    $0x8,%esp
     4f9:	68 3e 53 00 00       	push   $0x533e
     4fe:	6a 01                	push   $0x1
     500:	e8 ab 3d 00 00       	call   42b0 <printf>
  printf(1, "Calling shmctl with cmd=IPC_RMID:  ");
     505:	5f                   	pop    %edi
     506:	58                   	pop    %eax
     507:	68 80 49 00 00       	push   $0x4980
     50c:	6a 01                	push   $0x1
     50e:	e8 9d 3d 00 00       	call   42b0 <printf>
  shmctl(shmid, IPC_RMID, 0);
     513:	83 c4 0c             	add    $0xc,%esp
     516:	6a 00                	push   $0x0
     518:	6a 03                	push   $0x3
     51a:	53                   	push   %ebx
     51b:	e8 cb 3c 00 00       	call   41eb <shmctl>
  shmctl(shmid, IPC_STAT, buf);
     520:	83 c4 0c             	add    $0xc,%esp
     523:	56                   	push   %esi
     524:	6a 01                	push   $0x1
     526:	53                   	push   %ebx
     527:	e8 bf 3c 00 00       	call   41eb <shmctl>
  if(buf->shm_perm.mode == SHM_DEST){
     52c:	83 c4 10             	add    $0x10,%esp
     52f:	83 7e 04 20          	cmpl   $0x20,0x4(%esi)
     533:	74 33                	je     568 <shmctlTest+0x178>
  printf(1, "Passed\n");
     535:	83 ec 08             	sub    $0x8,%esp
     538:	68 3e 53 00 00       	push   $0x533e
     53d:	6a 01                	push   $0x1
     53f:	e8 6c 3d 00 00       	call   42b0 <printf>
  removeshm(0, 0);
     544:	58                   	pop    %eax
     545:	5a                   	pop    %edx
     546:	6a 00                	push   $0x0
     548:	6a 00                	push   $0x0
     54a:	e8 ac 3c 00 00       	call   41fb <removeshm>
  printf(1, "\n----------SHMCTL TEST PASSED!----------\n\n");
     54f:	59                   	pop    %ecx
     550:	5b                   	pop    %ebx
     551:	68 a4 49 00 00       	push   $0x49a4
     556:	6a 01                	push   $0x1
     558:	e8 53 3d 00 00       	call   42b0 <printf>
}
     55d:	83 c4 10             	add    $0x10,%esp
     560:	8d 65 f4             	lea    -0xc(%ebp),%esp
     563:	5b                   	pop    %ebx
     564:	5e                   	pop    %esi
     565:	5f                   	pop    %edi
     566:	5d                   	pop    %ebp
     567:	c3                   	ret
    printf(1, "Failed\n");
     568:	83 ec 08             	sub    $0x8,%esp
     56b:	68 63 53 00 00       	push   $0x5363
     570:	6a 01                	push   $0x1
     572:	e8 39 3d 00 00       	call   42b0 <printf>
    exit();
     577:	e8 b7 3b 00 00       	call   4133 <exit>
     57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <shmatTest>:
void shmatTest(){
     580:	55                   	push   %ebp
     581:	89 e5                	mov    %esp,%ebp
     583:	56                   	push   %esi
     584:	53                   	push   %ebx
  printf(1, "\n--------------SHMAT TEST--------------\n\nNULL input:  ");
     585:	83 ec 08             	sub    $0x8,%esp
     588:	68 d0 49 00 00       	push   $0x49d0
     58d:	6a 01                	push   $0x1
     58f:	e8 1c 3d 00 00       	call   42b0 <printf>
  int id = shmget(IPC_PRIVATE, 8096, IPC_CREAT); 
     594:	83 c4 0c             	add    $0xc,%esp
     597:	6a 04                	push   $0x4
     599:	68 a0 1f 00 00       	push   $0x1fa0
     59e:	68 61 79 fe ff       	push   $0xfffe7961
     5a3:	e8 2b 3c 00 00       	call   41d3 <shmget>
  void* va = shmat(id, 0, 0);
     5a8:	83 c4 0c             	add    $0xc,%esp
     5ab:	6a 00                	push   $0x0
  int id = shmget(IPC_PRIVATE, 8096, IPC_CREAT); 
     5ad:	89 c3                	mov    %eax,%ebx
  void* va = shmat(id, 0, 0);
     5af:	6a 00                	push   $0x0
     5b1:	50                   	push   %eax
     5b2:	e8 24 3c 00 00       	call   41db <shmat>
  if((int)va < 0){
     5b7:	83 c4 10             	add    $0x10,%esp
     5ba:	85 c0                	test   %eax,%eax
     5bc:	0f 88 7c 01 00 00    	js     73e <shmatTest+0x1be>
    printf(1, "passed\n");
     5c2:	83 ec 08             	sub    $0x8,%esp
     5c5:	89 c6                	mov    %eax,%esi
     5c7:	68 1c 64 00 00       	push   $0x641c
     5cc:	6a 01                	push   $0x1
     5ce:	e8 dd 3c 00 00       	call   42b0 <printf>
  shmdt((int)va);
     5d3:	89 34 24             	mov    %esi,(%esp)
     5d6:	e8 08 3c 00 00       	call   41e3 <shmdt>
  printf(1, "Invalid id:  ");
     5db:	59                   	pop    %ecx
     5dc:	5e                   	pop    %esi
     5dd:	68 89 53 00 00       	push   $0x5389
     5e2:	6a 01                	push   $0x1
     5e4:	e8 c7 3c 00 00       	call   42b0 <printf>
  void* va1 = shmat(-1, 0, 0);
     5e9:	83 c4 0c             	add    $0xc,%esp
     5ec:	6a 00                	push   $0x0
     5ee:	6a 00                	push   $0x0
     5f0:	6a ff                	push   $0xffffffff
     5f2:	e8 e4 3b 00 00       	call   41db <shmat>
  if((int)va1 >= 0){
     5f7:	83 c4 10             	add    $0x10,%esp
  void* va1 = shmat(-1, 0, 0);
     5fa:	89 c6                	mov    %eax,%esi
  if((int)va1 >= 0){
     5fc:	85 c0                	test   %eax,%eax
     5fe:	0f 89 3a 01 00 00    	jns    73e <shmatTest+0x1be>
    printf(1, "passed\n");
     604:	83 ec 08             	sub    $0x8,%esp
     607:	68 1c 64 00 00       	push   $0x641c
     60c:	6a 01                	push   $0x1
     60e:	e8 9d 3c 00 00       	call   42b0 <printf>
  shmdt((int)va1);
     613:	89 34 24             	mov    %esi,(%esp)
     616:	e8 c8 3b 00 00       	call   41e3 <shmdt>
  printf(1, "No segment with given id:  ");
     61b:	58                   	pop    %eax
     61c:	5a                   	pop    %edx
     61d:	68 97 53 00 00       	push   $0x5397
     622:	6a 01                	push   $0x1
     624:	e8 87 3c 00 00       	call   42b0 <printf>
  void* va2 = shmat(4000, 0, 0);
     629:	83 c4 0c             	add    $0xc,%esp
     62c:	6a 00                	push   $0x0
     62e:	6a 00                	push   $0x0
     630:	68 a0 0f 00 00       	push   $0xfa0
     635:	e8 a1 3b 00 00       	call   41db <shmat>
  if((int)va2 >= 0){
     63a:	83 c4 10             	add    $0x10,%esp
  void* va2 = shmat(4000, 0, 0);
     63d:	89 c6                	mov    %eax,%esi
  if((int)va2 >= 0){
     63f:	85 c0                	test   %eax,%eax
     641:	0f 89 f7 00 00 00    	jns    73e <shmatTest+0x1be>
    printf(1, "passed\n");
     647:	83 ec 08             	sub    $0x8,%esp
     64a:	68 1c 64 00 00       	push   $0x641c
     64f:	6a 01                	push   $0x1
     651:	e8 5a 3c 00 00       	call   42b0 <printf>
  shmdt((int)va2);
     656:	89 34 24             	mov    %esi,(%esp)
     659:	e8 85 3b 00 00       	call   41e3 <shmdt>
  printf(1, "Page address not aligned to page boundary:  ");
     65e:	59                   	pop    %ecx
     65f:	5e                   	pop    %esi
     660:	68 08 4a 00 00       	push   $0x4a08
     665:	6a 01                	push   $0x1
     667:	e8 44 3c 00 00       	call   42b0 <printf>
  void* va3 = shmat(id, 0x70000001, 0);
     66c:	83 c4 0c             	add    $0xc,%esp
     66f:	6a 00                	push   $0x0
     671:	68 01 00 00 70       	push   $0x70000001
     676:	53                   	push   %ebx
     677:	e8 5f 3b 00 00       	call   41db <shmat>
  if((int)va3 >= 0){
     67c:	83 c4 10             	add    $0x10,%esp
  void* va3 = shmat(id, 0x70000001, 0);
     67f:	89 c6                	mov    %eax,%esi
  if((int)va3 >= 0){
     681:	85 c0                	test   %eax,%eax
     683:	0f 89 b5 00 00 00    	jns    73e <shmatTest+0x1be>
    printf(1, "passed\n");
     689:	83 ec 08             	sub    $0x8,%esp
     68c:	68 1c 64 00 00       	push   $0x641c
     691:	6a 01                	push   $0x1
     693:	e8 18 3c 00 00       	call   42b0 <printf>
  shmdt((int)va3);  
     698:	89 34 24             	mov    %esi,(%esp)
     69b:	e8 43 3b 00 00       	call   41e3 <shmdt>
  printf(1, "Page address out of range:  ");
     6a0:	58                   	pop    %eax
     6a1:	5a                   	pop    %edx
     6a2:	68 b3 53 00 00       	push   $0x53b3
     6a7:	6a 01                	push   $0x1
     6a9:	e8 02 3c 00 00       	call   42b0 <printf>
  void* va4 = shmat(id, 0x90000000, 0);
     6ae:	83 c4 0c             	add    $0xc,%esp
     6b1:	6a 00                	push   $0x0
     6b3:	68 00 00 00 90       	push   $0x90000000
     6b8:	53                   	push   %ebx
     6b9:	e8 1d 3b 00 00       	call   41db <shmat>
  if((int)va4 >= 0){
     6be:	83 c4 10             	add    $0x10,%esp
  void* va4 = shmat(id, 0x90000000, 0);
     6c1:	89 c6                	mov    %eax,%esi
  if((int)va4 >= 0){
     6c3:	85 c0                	test   %eax,%eax
     6c5:	79 77                	jns    73e <shmatTest+0x1be>
    printf(1, "passed\n");
     6c7:	83 ec 08             	sub    $0x8,%esp
     6ca:	68 1c 64 00 00       	push   $0x641c
     6cf:	6a 01                	push   $0x1
     6d1:	e8 da 3b 00 00       	call   42b0 <printf>
  shmdt((int)va4);
     6d6:	89 34 24             	mov    %esi,(%esp)
     6d9:	e8 05 3b 00 00       	call   41e3 <shmdt>
  printf(1, "SHM_RND:  ");
     6de:	5e                   	pop    %esi
     6df:	58                   	pop    %eax
     6e0:	68 d0 53 00 00       	push   $0x53d0
     6e5:	6a 01                	push   $0x1
     6e7:	e8 c4 3b 00 00       	call   42b0 <printf>
  void* va5 = shmat(id, (int)0x7FF00001, SHM_RND);
     6ec:	83 c4 0c             	add    $0xc,%esp
     6ef:	6a 04                	push   $0x4
     6f1:	68 01 00 f0 7f       	push   $0x7ff00001
     6f6:	53                   	push   %ebx
     6f7:	e8 df 3a 00 00       	call   41db <shmat>
  if((int)va5 < 0){
     6fc:	83 c4 10             	add    $0x10,%esp
  void* va5 = shmat(id, (int)0x7FF00001, SHM_RND);
     6ff:	89 c6                	mov    %eax,%esi
  if((int)va5 < 0){
     701:	85 c0                	test   %eax,%eax
     703:	78 39                	js     73e <shmatTest+0x1be>
    printf(1, "passed\n");
     705:	83 ec 08             	sub    $0x8,%esp
     708:	68 1c 64 00 00       	push   $0x641c
     70d:	6a 01                	push   $0x1
     70f:	e8 9c 3b 00 00       	call   42b0 <printf>
  shmdt((int)va5); 
     714:	89 34 24             	mov    %esi,(%esp)
     717:	e8 c7 3a 00 00       	call   41e3 <shmdt>
  removeshm(id, 0);
     71c:	58                   	pop    %eax
     71d:	5a                   	pop    %edx
     71e:	6a 00                	push   $0x0
     720:	53                   	push   %ebx
     721:	e8 d5 3a 00 00       	call   41fb <removeshm>
  printf(1, "\n----------SHMAT TEST PASSED!----------\n\n");
     726:	59                   	pop    %ecx
     727:	5b                   	pop    %ebx
     728:	68 38 4a 00 00       	push   $0x4a38
     72d:	6a 01                	push   $0x1
     72f:	e8 7c 3b 00 00       	call   42b0 <printf>
}
     734:	83 c4 10             	add    $0x10,%esp
     737:	8d 65 f8             	lea    -0x8(%ebp),%esp
     73a:	5b                   	pop    %ebx
     73b:	5e                   	pop    %esi
     73c:	5d                   	pop    %ebp
     73d:	c3                   	ret
    printf(1, "Failed\n");
     73e:	83 ec 08             	sub    $0x8,%esp
     741:	68 63 53 00 00       	push   $0x5363
     746:	6a 01                	push   $0x1
     748:	e8 63 3b 00 00       	call   42b0 <printf>
    exit();
     74d:	e8 e1 39 00 00       	call   4133 <exit>
     752:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     759:	00 
     75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000760 <shmdtTest>:
void shmdtTest(){
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	53                   	push   %ebx
     764:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "\n--------------SHMDT TEST--------------\n\nNULL input:  ");
     767:	68 64 4a 00 00       	push   $0x4a64
     76c:	6a 01                	push   $0x1
     76e:	e8 3d 3b 00 00       	call   42b0 <printf>
  int id = shmget(IPC_PRIVATE, 8096, IPC_CREAT); 
     773:	83 c4 0c             	add    $0xc,%esp
     776:	6a 04                	push   $0x4
     778:	68 a0 1f 00 00       	push   $0x1fa0
     77d:	68 61 79 fe ff       	push   $0xfffe7961
     782:	e8 4c 3a 00 00       	call   41d3 <shmget>
  int ret = shmdt(0);
     787:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int id = shmget(IPC_PRIVATE, 8096, IPC_CREAT); 
     78e:	89 c3                	mov    %eax,%ebx
  int ret = shmdt(0);
     790:	e8 4e 3a 00 00       	call   41e3 <shmdt>
  if(ret == 0){
     795:	83 c4 10             	add    $0x10,%esp
     798:	85 c0                	test   %eax,%eax
     79a:	0f 84 98 00 00 00    	je     838 <shmdtTest+0xd8>
    printf(1, "passed\n");
     7a0:	83 ec 08             	sub    $0x8,%esp
     7a3:	68 1c 64 00 00       	push   $0x641c
     7a8:	6a 01                	push   $0x1
     7aa:	e8 01 3b 00 00       	call   42b0 <printf>
  printf(1, "Invalid address:   ");
     7af:	59                   	pop    %ecx
     7b0:	58                   	pop    %eax
     7b1:	68 db 53 00 00       	push   $0x53db
     7b6:	6a 01                	push   $0x1
     7b8:	e8 f3 3a 00 00       	call   42b0 <printf>
  int ret1 = shmdt(0x90000000);
     7bd:	c7 04 24 00 00 00 90 	movl   $0x90000000,(%esp)
     7c4:	e8 1a 3a 00 00       	call   41e3 <shmdt>
  if(ret1 == 0){
     7c9:	83 c4 10             	add    $0x10,%esp
     7cc:	85 c0                	test   %eax,%eax
     7ce:	74 68                	je     838 <shmdtTest+0xd8>
    printf(1, "passed\n");
     7d0:	83 ec 08             	sub    $0x8,%esp
     7d3:	68 1c 64 00 00       	push   $0x641c
     7d8:	6a 01                	push   $0x1
     7da:	e8 d1 3a 00 00       	call   42b0 <printf>
  printf(1, "Valid address:   ");
     7df:	58                   	pop    %eax
     7e0:	5a                   	pop    %edx
     7e1:	68 ef 53 00 00       	push   $0x53ef
     7e6:	6a 01                	push   $0x1
     7e8:	e8 c3 3a 00 00       	call   42b0 <printf>
  void* va = shmat(id, 0 , 0);
     7ed:	83 c4 0c             	add    $0xc,%esp
     7f0:	6a 00                	push   $0x0
     7f2:	6a 00                	push   $0x0
     7f4:	53                   	push   %ebx
     7f5:	e8 e1 39 00 00       	call   41db <shmat>
  int ret2 = shmdt((int)va);
     7fa:	89 04 24             	mov    %eax,(%esp)
     7fd:	e8 e1 39 00 00       	call   41e3 <shmdt>
  if(ret2 != 0){
     802:	83 c4 10             	add    $0x10,%esp
     805:	85 c0                	test   %eax,%eax
     807:	75 2f                	jne    838 <shmdtTest+0xd8>
    printf(1, "passed\n");
     809:	83 ec 08             	sub    $0x8,%esp
     80c:	68 1c 64 00 00       	push   $0x641c
     811:	6a 01                	push   $0x1
     813:	e8 98 3a 00 00       	call   42b0 <printf>
  removeshm(id, 0);
     818:	58                   	pop    %eax
     819:	5a                   	pop    %edx
     81a:	6a 00                	push   $0x0
     81c:	53                   	push   %ebx
     81d:	e8 d9 39 00 00       	call   41fb <removeshm>
  printf(1, "\n----------SHMDT TEST PASSED!----------\n\n");
     822:	59                   	pop    %ecx
     823:	5b                   	pop    %ebx
     824:	68 9c 4a 00 00       	push   $0x4a9c
     829:	6a 01                	push   $0x1
     82b:	e8 80 3a 00 00       	call   42b0 <printf>
}
     830:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     833:	83 c4 10             	add    $0x10,%esp
     836:	c9                   	leave
     837:	c3                   	ret
    printf(1, "Failed\n");
     838:	83 ec 08             	sub    $0x8,%esp
     83b:	68 63 53 00 00       	push   $0x5363
     840:	6a 01                	push   $0x1
     842:	e8 69 3a 00 00       	call   42b0 <printf>
    exit();
     847:	e8 e7 38 00 00       	call   4133 <exit>
     84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000850 <test_read_and_write_simple>:
void test_read_and_write_simple(){
     850:	55                   	push   %ebp
     851:	89 e5                	mov    %esp,%ebp
     853:	56                   	push   %esi
     854:	53                   	push   %ebx
  printf(1,"\n----------READ WRITE TO SHARED MEMORY TEST----------\n\nSingle Read and Write   ");
     855:	83 ec 08             	sub    $0x8,%esp
     858:	68 c8 4a 00 00       	push   $0x4ac8
     85d:	6a 01                	push   $0x1
     85f:	e8 4c 3a 00 00       	call   42b0 <printf>
  int id = shmget(IPC_PRIVATE, 8096, IPC_CREAT); 
     864:	83 c4 0c             	add    $0xc,%esp
     867:	6a 04                	push   $0x4
     869:	68 a0 1f 00 00       	push   $0x1fa0
     86e:	68 61 79 fe ff       	push   $0xfffe7961
     873:	e8 5b 39 00 00       	call   41d3 <shmget>
  char* va = (char*)shmat(id, 0, SHM_W | SHM_R);
     878:	83 c4 0c             	add    $0xc,%esp
     87b:	6a 03                	push   $0x3
     87d:	6a 00                	push   $0x0
     87f:	50                   	push   %eax
     880:	e8 56 39 00 00       	call   41db <shmat>
  if((int)va < 0) {
     885:	83 c4 10             	add    $0x10,%esp
  char* va = (char*)shmat(id, 0, SHM_W | SHM_R);
     888:	89 c3                	mov    %eax,%ebx
  if((int)va < 0) {
     88a:	85 c0                	test   %eax,%eax
     88c:	0f 88 bd 00 00 00    	js     94f <test_read_and_write_simple+0xff>
  printf(1,"\n");
     892:	83 ec 08             	sub    $0x8,%esp
  for (int i=0; data[i] != 0; i++) {
     895:	31 f6                	xor    %esi,%esi
  printf(1,"\n");
     897:	68 58 58 00 00       	push   $0x5858
     89c:	6a 01                	push   $0x1
     89e:	e8 0d 3a 00 00       	call   42b0 <printf>
  printf(1,"Data written to shared memory: ");
     8a3:	5a                   	pop    %edx
     8a4:	59                   	pop    %ecx
     8a5:	68 44 4b 00 00       	push   $0x4b44
     8aa:	6a 01                	push   $0x1
     8ac:	e8 ff 39 00 00       	call   42b0 <printf>
     8b1:	83 c4 10             	add    $0x10,%esp
  for (int i=0; data[i] != 0; i++) {
     8b4:	b8 48 00 00 00       	mov    $0x48,%eax
     8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1,"%c", va[i]);
     8c0:	83 ec 04             	sub    $0x4,%esp
      va[i] = data[i];
     8c3:	88 04 33             	mov    %al,(%ebx,%esi,1)
  for (int i=0; data[i] != 0; i++) {
     8c6:	83 c6 01             	add    $0x1,%esi
      printf(1,"%c", va[i]);
     8c9:	50                   	push   %eax
     8ca:	68 01 54 00 00       	push   $0x5401
     8cf:	6a 01                	push   $0x1
     8d1:	e8 da 39 00 00       	call   42b0 <printf>
  for (int i=0; data[i] != 0; i++) {
     8d6:	0f be 86 04 54 00 00 	movsbl 0x5404(%esi),%eax
     8dd:	83 c4 10             	add    $0x10,%esp
     8e0:	84 c0                	test   %al,%al
     8e2:	75 dc                	jne    8c0 <test_read_and_write_simple+0x70>
  printf(1,"\nData read from memory: %s\n", (char*)data);
     8e4:	83 ec 04             	sub    $0x4,%esp
     8e7:	68 04 54 00 00       	push   $0x5404
     8ec:	68 1a 54 00 00       	push   $0x541a
     8f1:	6a 01                	push   $0x1
     8f3:	e8 b8 39 00 00       	call   42b0 <printf>
  for(int i=0 ; va[i] != 0; i++){
     8f8:	0f be 03             	movsbl (%ebx),%eax
     8fb:	83 c4 10             	add    $0x10,%esp
     8fe:	84 c0                	test   %al,%al
     900:	74 24                	je     926 <test_read_and_write_simple+0xd6>
     902:	8d 73 01             	lea    0x1(%ebx),%esi
     905:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1,"%c",va[i]);
     908:	83 ec 04             	sub    $0x4,%esp
  for(int i=0 ; va[i] != 0; i++){
     90b:	83 c6 01             	add    $0x1,%esi
    printf(1,"%c",va[i]);
     90e:	50                   	push   %eax
     90f:	68 01 54 00 00       	push   $0x5401
     914:	6a 01                	push   $0x1
     916:	e8 95 39 00 00       	call   42b0 <printf>
  for(int i=0 ; va[i] != 0; i++){
     91b:	0f be 46 ff          	movsbl -0x1(%esi),%eax
     91f:	83 c4 10             	add    $0x10,%esp
     922:	84 c0                	test   %al,%al
     924:	75 e2                	jne    908 <test_read_and_write_simple+0xb8>
  int ret = shmdt((int)va);
     926:	83 ec 0c             	sub    $0xc,%esp
     929:	53                   	push   %ebx
     92a:	e8 b4 38 00 00       	call   41e3 <shmdt>
  if(ret != 0) {
     92f:	83 c4 10             	add    $0x10,%esp
     932:	85 c0                	test   %eax,%eax
     934:	75 2c                	jne    962 <test_read_and_write_simple+0x112>
  printf(1,"\n----------READ WRITE TO SHARED MEMORY TEST PASSED!----------\n\n");
     936:	83 ec 08             	sub    $0x8,%esp
     939:	68 8c 4b 00 00       	push   $0x4b8c
     93e:	6a 01                	push   $0x1
     940:	e8 6b 39 00 00       	call   42b0 <printf>
}
     945:	83 c4 10             	add    $0x10,%esp
     948:	8d 65 f8             	lea    -0x8(%ebp),%esp
     94b:	5b                   	pop    %ebx
     94c:	5e                   	pop    %esi
     94d:	5d                   	pop    %ebp
     94e:	c3                   	ret
      printf(1,"Failed to attach shared memory segment %d \n",(int)va);
     94f:	56                   	push   %esi
     950:	50                   	push   %eax
     951:	68 18 4b 00 00       	push   $0x4b18
     956:	6a 01                	push   $0x1
     958:	e8 53 39 00 00       	call   42b0 <printf>
      exit();
     95d:	e8 d1 37 00 00       	call   4133 <exit>
      printf(1,"Failed to detach shared memory segment\n");
     962:	50                   	push   %eax
     963:	50                   	push   %eax
     964:	68 64 4b 00 00       	push   $0x4b64
     969:	6a 01                	push   $0x1
     96b:	e8 40 39 00 00       	call   42b0 <printf>
      exit();
     970:	e8 be 37 00 00       	call   4133 <exit>
     975:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     97c:	00 
     97d:	8d 76 00             	lea    0x0(%esi),%esi

00000980 <iputtest>:
{
     980:	55                   	push   %ebp
     981:	89 e5                	mov    %esp,%ebp
     983:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     986:	68 ca 54 00 00       	push   $0x54ca
     98b:	ff 35 78 6e 00 00    	push   0x6e78
     991:	e8 1a 39 00 00       	call   42b0 <printf>
  if(mkdir("iputdir") < 0){
     996:	c7 04 24 5d 54 00 00 	movl   $0x545d,(%esp)
     99d:	e8 f9 37 00 00       	call   419b <mkdir>
     9a2:	83 c4 10             	add    $0x10,%esp
     9a5:	85 c0                	test   %eax,%eax
     9a7:	78 58                	js     a01 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     9a9:	83 ec 0c             	sub    $0xc,%esp
     9ac:	68 5d 54 00 00       	push   $0x545d
     9b1:	e8 ed 37 00 00       	call   41a3 <chdir>
     9b6:	83 c4 10             	add    $0x10,%esp
     9b9:	85 c0                	test   %eax,%eax
     9bb:	0f 88 85 00 00 00    	js     a46 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 5a 54 00 00       	push   $0x545a
     9c9:	e8 b5 37 00 00       	call   4183 <unlink>
     9ce:	83 c4 10             	add    $0x10,%esp
     9d1:	85 c0                	test   %eax,%eax
     9d3:	78 5a                	js     a2f <iputtest+0xaf>
  if(chdir("/") < 0){
     9d5:	83 ec 0c             	sub    $0xc,%esp
     9d8:	68 7f 54 00 00       	push   $0x547f
     9dd:	e8 c1 37 00 00       	call   41a3 <chdir>
     9e2:	83 c4 10             	add    $0x10,%esp
     9e5:	85 c0                	test   %eax,%eax
     9e7:	78 2f                	js     a18 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     9e9:	83 ec 08             	sub    $0x8,%esp
     9ec:	68 02 55 00 00       	push   $0x5502
     9f1:	ff 35 78 6e 00 00    	push   0x6e78
     9f7:	e8 b4 38 00 00       	call   42b0 <printf>
}
     9fc:	83 c4 10             	add    $0x10,%esp
     9ff:	c9                   	leave
     a00:	c3                   	ret
    printf(stdout, "mkdir failed\n");
     a01:	50                   	push   %eax
     a02:	50                   	push   %eax
     a03:	68 36 54 00 00       	push   $0x5436
     a08:	ff 35 78 6e 00 00    	push   0x6e78
     a0e:	e8 9d 38 00 00       	call   42b0 <printf>
    exit();
     a13:	e8 1b 37 00 00       	call   4133 <exit>
    printf(stdout, "chdir / failed\n");
     a18:	50                   	push   %eax
     a19:	50                   	push   %eax
     a1a:	68 81 54 00 00       	push   $0x5481
     a1f:	ff 35 78 6e 00 00    	push   0x6e78
     a25:	e8 86 38 00 00       	call   42b0 <printf>
    exit();
     a2a:	e8 04 37 00 00       	call   4133 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     a2f:	52                   	push   %edx
     a30:	52                   	push   %edx
     a31:	68 65 54 00 00       	push   $0x5465
     a36:	ff 35 78 6e 00 00    	push   0x6e78
     a3c:	e8 6f 38 00 00       	call   42b0 <printf>
    exit();
     a41:	e8 ed 36 00 00       	call   4133 <exit>
    printf(stdout, "chdir iputdir failed\n");
     a46:	51                   	push   %ecx
     a47:	51                   	push   %ecx
     a48:	68 44 54 00 00       	push   $0x5444
     a4d:	ff 35 78 6e 00 00    	push   0x6e78
     a53:	e8 58 38 00 00       	call   42b0 <printf>
    exit();
     a58:	e8 d6 36 00 00       	call   4133 <exit>
     a5d:	8d 76 00             	lea    0x0(%esi),%esi

00000a60 <exitiputtest>:
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     a66:	68 91 54 00 00       	push   $0x5491
     a6b:	ff 35 78 6e 00 00    	push   0x6e78
     a71:	e8 3a 38 00 00       	call   42b0 <printf>
  pid = fork();
     a76:	e8 b0 36 00 00       	call   412b <fork>
  if(pid < 0){
     a7b:	83 c4 10             	add    $0x10,%esp
     a7e:	85 c0                	test   %eax,%eax
     a80:	0f 88 8a 00 00 00    	js     b10 <exitiputtest+0xb0>
  if(pid == 0){
     a86:	75 50                	jne    ad8 <exitiputtest+0x78>
    if(mkdir("iputdir") < 0){
     a88:	83 ec 0c             	sub    $0xc,%esp
     a8b:	68 5d 54 00 00       	push   $0x545d
     a90:	e8 06 37 00 00       	call   419b <mkdir>
     a95:	83 c4 10             	add    $0x10,%esp
     a98:	85 c0                	test   %eax,%eax
     a9a:	0f 88 87 00 00 00    	js     b27 <exitiputtest+0xc7>
    if(chdir("iputdir") < 0){
     aa0:	83 ec 0c             	sub    $0xc,%esp
     aa3:	68 5d 54 00 00       	push   $0x545d
     aa8:	e8 f6 36 00 00       	call   41a3 <chdir>
     aad:	83 c4 10             	add    $0x10,%esp
     ab0:	85 c0                	test   %eax,%eax
     ab2:	0f 88 86 00 00 00    	js     b3e <exitiputtest+0xde>
    if(unlink("../iputdir") < 0){
     ab8:	83 ec 0c             	sub    $0xc,%esp
     abb:	68 5a 54 00 00       	push   $0x545a
     ac0:	e8 be 36 00 00       	call   4183 <unlink>
     ac5:	83 c4 10             	add    $0x10,%esp
     ac8:	85 c0                	test   %eax,%eax
     aca:	78 2c                	js     af8 <exitiputtest+0x98>
    exit();
     acc:	e8 62 36 00 00       	call   4133 <exit>
     ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  wait();
     ad8:	e8 5e 36 00 00       	call   413b <wait>
  printf(stdout, "exitiput test ok\n");
     add:	83 ec 08             	sub    $0x8,%esp
     ae0:	68 b4 54 00 00       	push   $0x54b4
     ae5:	ff 35 78 6e 00 00    	push   0x6e78
     aeb:	e8 c0 37 00 00       	call   42b0 <printf>
}
     af0:	83 c4 10             	add    $0x10,%esp
     af3:	c9                   	leave
     af4:	c3                   	ret
     af5:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     af8:	83 ec 08             	sub    $0x8,%esp
     afb:	68 65 54 00 00       	push   $0x5465
     b00:	ff 35 78 6e 00 00    	push   0x6e78
     b06:	e8 a5 37 00 00       	call   42b0 <printf>
      exit();
     b0b:	e8 23 36 00 00       	call   4133 <exit>
    printf(stdout, "fork failed\n");
     b10:	51                   	push   %ecx
     b11:	51                   	push   %ecx
     b12:	68 77 63 00 00       	push   $0x6377
     b17:	ff 35 78 6e 00 00    	push   0x6e78
     b1d:	e8 8e 37 00 00       	call   42b0 <printf>
    exit();
     b22:	e8 0c 36 00 00       	call   4133 <exit>
      printf(stdout, "mkdir failed\n");
     b27:	52                   	push   %edx
     b28:	52                   	push   %edx
     b29:	68 36 54 00 00       	push   $0x5436
     b2e:	ff 35 78 6e 00 00    	push   0x6e78
     b34:	e8 77 37 00 00       	call   42b0 <printf>
      exit();
     b39:	e8 f5 35 00 00       	call   4133 <exit>
      printf(stdout, "child chdir failed\n");
     b3e:	50                   	push   %eax
     b3f:	50                   	push   %eax
     b40:	68 a0 54 00 00       	push   $0x54a0
     b45:	ff 35 78 6e 00 00    	push   0x6e78
     b4b:	e8 60 37 00 00       	call   42b0 <printf>
      exit();
     b50:	e8 de 35 00 00       	call   4133 <exit>
     b55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b5c:	00 
     b5d:	8d 76 00             	lea    0x0(%esi),%esi

00000b60 <openiputtest>:
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     b66:	68 c6 54 00 00       	push   $0x54c6
     b6b:	ff 35 78 6e 00 00    	push   0x6e78
     b71:	e8 3a 37 00 00       	call   42b0 <printf>
  if(mkdir("oidir") < 0){
     b76:	c7 04 24 d5 54 00 00 	movl   $0x54d5,(%esp)
     b7d:	e8 19 36 00 00       	call   419b <mkdir>
     b82:	83 c4 10             	add    $0x10,%esp
     b85:	85 c0                	test   %eax,%eax
     b87:	0f 88 9f 00 00 00    	js     c2c <openiputtest+0xcc>
  pid = fork();
     b8d:	e8 99 35 00 00       	call   412b <fork>
  if(pid < 0){
     b92:	85 c0                	test   %eax,%eax
     b94:	78 7f                	js     c15 <openiputtest+0xb5>
  if(pid == 0){
     b96:	75 38                	jne    bd0 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     b98:	83 ec 08             	sub    $0x8,%esp
     b9b:	6a 02                	push   $0x2
     b9d:	68 d5 54 00 00       	push   $0x54d5
     ba2:	e8 cc 35 00 00       	call   4173 <open>
    if(fd >= 0){
     ba7:	83 c4 10             	add    $0x10,%esp
     baa:	85 c0                	test   %eax,%eax
     bac:	78 62                	js     c10 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     bae:	83 ec 08             	sub    $0x8,%esp
     bb1:	68 cc 4b 00 00       	push   $0x4bcc
     bb6:	ff 35 78 6e 00 00    	push   0x6e78
     bbc:	e8 ef 36 00 00       	call   42b0 <printf>
      exit();
     bc1:	e8 6d 35 00 00       	call   4133 <exit>
     bc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     bcd:	00 
     bce:	66 90                	xchg   %ax,%ax
  sleep(1);
     bd0:	83 ec 0c             	sub    $0xc,%esp
     bd3:	6a 01                	push   $0x1
     bd5:	e8 e9 35 00 00       	call   41c3 <sleep>
  if(unlink("oidir") != 0){
     bda:	c7 04 24 d5 54 00 00 	movl   $0x54d5,(%esp)
     be1:	e8 9d 35 00 00       	call   4183 <unlink>
     be6:	83 c4 10             	add    $0x10,%esp
     be9:	85 c0                	test   %eax,%eax
     beb:	75 56                	jne    c43 <openiputtest+0xe3>
  wait();
     bed:	e8 49 35 00 00       	call   413b <wait>
  printf(stdout, "openiput test ok\n");
     bf2:	83 ec 08             	sub    $0x8,%esp
     bf5:	68 fe 54 00 00       	push   $0x54fe
     bfa:	ff 35 78 6e 00 00    	push   0x6e78
     c00:	e8 ab 36 00 00       	call   42b0 <printf>
}
     c05:	83 c4 10             	add    $0x10,%esp
     c08:	c9                   	leave
     c09:	c3                   	ret
     c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     c10:	e8 1e 35 00 00       	call   4133 <exit>
    printf(stdout, "fork failed\n");
     c15:	52                   	push   %edx
     c16:	52                   	push   %edx
     c17:	68 77 63 00 00       	push   $0x6377
     c1c:	ff 35 78 6e 00 00    	push   0x6e78
     c22:	e8 89 36 00 00       	call   42b0 <printf>
    exit();
     c27:	e8 07 35 00 00       	call   4133 <exit>
    printf(stdout, "mkdir oidir failed\n");
     c2c:	51                   	push   %ecx
     c2d:	51                   	push   %ecx
     c2e:	68 db 54 00 00       	push   $0x54db
     c33:	ff 35 78 6e 00 00    	push   0x6e78
     c39:	e8 72 36 00 00       	call   42b0 <printf>
    exit();
     c3e:	e8 f0 34 00 00       	call   4133 <exit>
    printf(stdout, "unlink failed\n");
     c43:	50                   	push   %eax
     c44:	50                   	push   %eax
     c45:	68 ef 54 00 00       	push   $0x54ef
     c4a:	ff 35 78 6e 00 00    	push   0x6e78
     c50:	e8 5b 36 00 00       	call   42b0 <printf>
    exit();
     c55:	e8 d9 34 00 00       	call   4133 <exit>
     c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c60 <opentest>:
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     c66:	68 10 55 00 00       	push   $0x5510
     c6b:	ff 35 78 6e 00 00    	push   0x6e78
     c71:	e8 3a 36 00 00       	call   42b0 <printf>
  fd = open("echo", 0);
     c76:	58                   	pop    %eax
     c77:	5a                   	pop    %edx
     c78:	6a 00                	push   $0x0
     c7a:	68 1b 55 00 00       	push   $0x551b
     c7f:	e8 ef 34 00 00       	call   4173 <open>
  if(fd < 0){
     c84:	83 c4 10             	add    $0x10,%esp
     c87:	85 c0                	test   %eax,%eax
     c89:	78 36                	js     cc1 <opentest+0x61>
  close(fd);
     c8b:	83 ec 0c             	sub    $0xc,%esp
     c8e:	50                   	push   %eax
     c8f:	e8 c7 34 00 00       	call   415b <close>
  fd = open("doesnotexist", 0);
     c94:	5a                   	pop    %edx
     c95:	59                   	pop    %ecx
     c96:	6a 00                	push   $0x0
     c98:	68 33 55 00 00       	push   $0x5533
     c9d:	e8 d1 34 00 00       	call   4173 <open>
  if(fd >= 0){
     ca2:	83 c4 10             	add    $0x10,%esp
     ca5:	85 c0                	test   %eax,%eax
     ca7:	79 2f                	jns    cd8 <opentest+0x78>
  printf(stdout, "open test ok\n");
     ca9:	83 ec 08             	sub    $0x8,%esp
     cac:	68 5e 55 00 00       	push   $0x555e
     cb1:	ff 35 78 6e 00 00    	push   0x6e78
     cb7:	e8 f4 35 00 00       	call   42b0 <printf>
}
     cbc:	83 c4 10             	add    $0x10,%esp
     cbf:	c9                   	leave
     cc0:	c3                   	ret
    printf(stdout, "open echo failed!\n");
     cc1:	50                   	push   %eax
     cc2:	50                   	push   %eax
     cc3:	68 20 55 00 00       	push   $0x5520
     cc8:	ff 35 78 6e 00 00    	push   0x6e78
     cce:	e8 dd 35 00 00       	call   42b0 <printf>
    exit();
     cd3:	e8 5b 34 00 00       	call   4133 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     cd8:	50                   	push   %eax
     cd9:	50                   	push   %eax
     cda:	68 40 55 00 00       	push   $0x5540
     cdf:	ff 35 78 6e 00 00    	push   0x6e78
     ce5:	e8 c6 35 00 00       	call   42b0 <printf>
    exit();
     cea:	e8 44 34 00 00       	call   4133 <exit>
     cef:	90                   	nop

00000cf0 <writetest>:
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	56                   	push   %esi
     cf4:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     cf5:	83 ec 08             	sub    $0x8,%esp
     cf8:	68 6c 55 00 00       	push   $0x556c
     cfd:	ff 35 78 6e 00 00    	push   0x6e78
     d03:	e8 a8 35 00 00       	call   42b0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     d08:	58                   	pop    %eax
     d09:	5a                   	pop    %edx
     d0a:	68 02 02 00 00       	push   $0x202
     d0f:	68 7d 55 00 00       	push   $0x557d
     d14:	e8 5a 34 00 00       	call   4173 <open>
  if(fd >= 0){
     d19:	83 c4 10             	add    $0x10,%esp
     d1c:	85 c0                	test   %eax,%eax
     d1e:	0f 88 88 01 00 00    	js     eac <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     d24:	83 ec 08             	sub    $0x8,%esp
     d27:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     d29:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     d2b:	68 83 55 00 00       	push   $0x5583
     d30:	ff 35 78 6e 00 00    	push   0x6e78
     d36:	e8 75 35 00 00       	call   42b0 <printf>
     d3b:	83 c4 10             	add    $0x10,%esp
     d3e:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     d40:	83 ec 04             	sub    $0x4,%esp
     d43:	6a 0a                	push   $0xa
     d45:	68 ba 55 00 00       	push   $0x55ba
     d4a:	56                   	push   %esi
     d4b:	e8 03 34 00 00       	call   4153 <write>
     d50:	83 c4 10             	add    $0x10,%esp
     d53:	83 f8 0a             	cmp    $0xa,%eax
     d56:	0f 85 d9 00 00 00    	jne    e35 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     d5c:	83 ec 04             	sub    $0x4,%esp
     d5f:	6a 0a                	push   $0xa
     d61:	68 c5 55 00 00       	push   $0x55c5
     d66:	56                   	push   %esi
     d67:	e8 e7 33 00 00       	call   4153 <write>
     d6c:	83 c4 10             	add    $0x10,%esp
     d6f:	83 f8 0a             	cmp    $0xa,%eax
     d72:	0f 85 d6 00 00 00    	jne    e4e <writetest+0x15e>
  for(i = 0; i < 100; i++){
     d78:	83 c3 01             	add    $0x1,%ebx
     d7b:	83 fb 64             	cmp    $0x64,%ebx
     d7e:	75 c0                	jne    d40 <writetest+0x50>
  printf(stdout, "writes ok\n");
     d80:	83 ec 08             	sub    $0x8,%esp
     d83:	68 d0 55 00 00       	push   $0x55d0
     d88:	ff 35 78 6e 00 00    	push   0x6e78
     d8e:	e8 1d 35 00 00       	call   42b0 <printf>
  close(fd);
     d93:	89 34 24             	mov    %esi,(%esp)
     d96:	e8 c0 33 00 00       	call   415b <close>
  fd = open("small", O_RDONLY);
     d9b:	5b                   	pop    %ebx
     d9c:	5e                   	pop    %esi
     d9d:	6a 00                	push   $0x0
     d9f:	68 7d 55 00 00       	push   $0x557d
     da4:	e8 ca 33 00 00       	call   4173 <open>
  if(fd >= 0){
     da9:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     dac:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     dae:	85 c0                	test   %eax,%eax
     db0:	0f 88 b1 00 00 00    	js     e67 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     db6:	83 ec 08             	sub    $0x8,%esp
     db9:	68 db 55 00 00       	push   $0x55db
     dbe:	ff 35 78 6e 00 00    	push   0x6e78
     dc4:	e8 e7 34 00 00       	call   42b0 <printf>
  i = read(fd, buf, 2000);
     dc9:	83 c4 0c             	add    $0xc,%esp
     dcc:	68 d0 07 00 00       	push   $0x7d0
     dd1:	68 c0 95 00 00       	push   $0x95c0
     dd6:	53                   	push   %ebx
     dd7:	e8 6f 33 00 00       	call   414b <read>
  if(i == 2000){
     ddc:	83 c4 10             	add    $0x10,%esp
     ddf:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     de4:	0f 85 94 00 00 00    	jne    e7e <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     dea:	83 ec 08             	sub    $0x8,%esp
     ded:	68 0f 56 00 00       	push   $0x560f
     df2:	ff 35 78 6e 00 00    	push   0x6e78
     df8:	e8 b3 34 00 00       	call   42b0 <printf>
  close(fd);
     dfd:	89 1c 24             	mov    %ebx,(%esp)
     e00:	e8 56 33 00 00       	call   415b <close>
  if(unlink("small") < 0){
     e05:	c7 04 24 7d 55 00 00 	movl   $0x557d,(%esp)
     e0c:	e8 72 33 00 00       	call   4183 <unlink>
     e11:	83 c4 10             	add    $0x10,%esp
     e14:	85 c0                	test   %eax,%eax
     e16:	78 7d                	js     e95 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     e18:	83 ec 08             	sub    $0x8,%esp
     e1b:	68 37 56 00 00       	push   $0x5637
     e20:	ff 35 78 6e 00 00    	push   0x6e78
     e26:	e8 85 34 00 00       	call   42b0 <printf>
}
     e2b:	83 c4 10             	add    $0x10,%esp
     e2e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e31:	5b                   	pop    %ebx
     e32:	5e                   	pop    %esi
     e33:	5d                   	pop    %ebp
     e34:	c3                   	ret
      printf(stdout, "error: write aa %d new file failed\n", i);
     e35:	83 ec 04             	sub    $0x4,%esp
     e38:	53                   	push   %ebx
     e39:	68 f0 4b 00 00       	push   $0x4bf0
     e3e:	ff 35 78 6e 00 00    	push   0x6e78
     e44:	e8 67 34 00 00       	call   42b0 <printf>
      exit();
     e49:	e8 e5 32 00 00       	call   4133 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     e4e:	83 ec 04             	sub    $0x4,%esp
     e51:	53                   	push   %ebx
     e52:	68 14 4c 00 00       	push   $0x4c14
     e57:	ff 35 78 6e 00 00    	push   0x6e78
     e5d:	e8 4e 34 00 00       	call   42b0 <printf>
      exit();
     e62:	e8 cc 32 00 00       	call   4133 <exit>
    printf(stdout, "error: open small failed!\n");
     e67:	51                   	push   %ecx
     e68:	51                   	push   %ecx
     e69:	68 f4 55 00 00       	push   $0x55f4
     e6e:	ff 35 78 6e 00 00    	push   0x6e78
     e74:	e8 37 34 00 00       	call   42b0 <printf>
    exit();
     e79:	e8 b5 32 00 00       	call   4133 <exit>
    printf(stdout, "read failed\n");
     e7e:	52                   	push   %edx
     e7f:	52                   	push   %edx
     e80:	68 3b 59 00 00       	push   $0x593b
     e85:	ff 35 78 6e 00 00    	push   0x6e78
     e8b:	e8 20 34 00 00       	call   42b0 <printf>
    exit();
     e90:	e8 9e 32 00 00       	call   4133 <exit>
    printf(stdout, "unlink small failed\n");
     e95:	50                   	push   %eax
     e96:	50                   	push   %eax
     e97:	68 22 56 00 00       	push   $0x5622
     e9c:	ff 35 78 6e 00 00    	push   0x6e78
     ea2:	e8 09 34 00 00       	call   42b0 <printf>
    exit();
     ea7:	e8 87 32 00 00       	call   4133 <exit>
    printf(stdout, "error: creat small failed!\n");
     eac:	50                   	push   %eax
     ead:	50                   	push   %eax
     eae:	68 9e 55 00 00       	push   $0x559e
     eb3:	ff 35 78 6e 00 00    	push   0x6e78
     eb9:	e8 f2 33 00 00       	call   42b0 <printf>
    exit();
     ebe:	e8 70 32 00 00       	call   4133 <exit>
     ec3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     eca:	00 
     ecb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000ed0 <writetest1>:
{
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	56                   	push   %esi
     ed4:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     ed5:	83 ec 08             	sub    $0x8,%esp
     ed8:	68 4b 56 00 00       	push   $0x564b
     edd:	ff 35 78 6e 00 00    	push   0x6e78
     ee3:	e8 c8 33 00 00       	call   42b0 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     ee8:	58                   	pop    %eax
     ee9:	5a                   	pop    %edx
     eea:	68 02 02 00 00       	push   $0x202
     eef:	68 c5 56 00 00       	push   $0x56c5
     ef4:	e8 7a 32 00 00       	call   4173 <open>
  if(fd < 0){
     ef9:	83 c4 10             	add    $0x10,%esp
     efc:	85 c0                	test   %eax,%eax
     efe:	0f 88 61 01 00 00    	js     1065 <writetest1+0x195>
     f04:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     f06:	31 db                	xor    %ebx,%ebx
     f08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f0f:	00 
    if(write(fd, buf, 512) != 512){
     f10:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     f13:	89 1d c0 95 00 00    	mov    %ebx,0x95c0
    if(write(fd, buf, 512) != 512){
     f19:	68 00 02 00 00       	push   $0x200
     f1e:	68 c0 95 00 00       	push   $0x95c0
     f23:	56                   	push   %esi
     f24:	e8 2a 32 00 00       	call   4153 <write>
     f29:	83 c4 10             	add    $0x10,%esp
     f2c:	3d 00 02 00 00       	cmp    $0x200,%eax
     f31:	0f 85 b3 00 00 00    	jne    fea <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     f37:	83 c3 01             	add    $0x1,%ebx
     f3a:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     f40:	75 ce                	jne    f10 <writetest1+0x40>
  close(fd);
     f42:	83 ec 0c             	sub    $0xc,%esp
     f45:	56                   	push   %esi
     f46:	e8 10 32 00 00       	call   415b <close>
  fd = open("big", O_RDONLY);
     f4b:	5b                   	pop    %ebx
     f4c:	5e                   	pop    %esi
     f4d:	6a 00                	push   $0x0
     f4f:	68 c5 56 00 00       	push   $0x56c5
     f54:	e8 1a 32 00 00       	call   4173 <open>
  if(fd < 0){
     f59:	83 c4 10             	add    $0x10,%esp
  fd = open("big", O_RDONLY);
     f5c:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     f5e:	85 c0                	test   %eax,%eax
     f60:	0f 88 e8 00 00 00    	js     104e <writetest1+0x17e>
  n = 0;
     f66:	31 f6                	xor    %esi,%esi
     f68:	eb 1d                	jmp    f87 <writetest1+0xb7>
     f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     f70:	3d 00 02 00 00       	cmp    $0x200,%eax
     f75:	0f 85 9f 00 00 00    	jne    101a <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     f7b:	a1 c0 95 00 00       	mov    0x95c0,%eax
     f80:	39 f0                	cmp    %esi,%eax
     f82:	75 7f                	jne    1003 <writetest1+0x133>
    n++;
     f84:	83 c6 01             	add    $0x1,%esi
    i = read(fd, buf, 512);
     f87:	83 ec 04             	sub    $0x4,%esp
     f8a:	68 00 02 00 00       	push   $0x200
     f8f:	68 c0 95 00 00       	push   $0x95c0
     f94:	53                   	push   %ebx
     f95:	e8 b1 31 00 00       	call   414b <read>
    if(i == 0){
     f9a:	83 c4 10             	add    $0x10,%esp
     f9d:	85 c0                	test   %eax,%eax
     f9f:	75 cf                	jne    f70 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     fa1:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     fa7:	0f 84 86 00 00 00    	je     1033 <writetest1+0x163>
  close(fd);
     fad:	83 ec 0c             	sub    $0xc,%esp
     fb0:	53                   	push   %ebx
     fb1:	e8 a5 31 00 00       	call   415b <close>
  if(unlink("big") < 0){
     fb6:	c7 04 24 c5 56 00 00 	movl   $0x56c5,(%esp)
     fbd:	e8 c1 31 00 00       	call   4183 <unlink>
     fc2:	83 c4 10             	add    $0x10,%esp
     fc5:	85 c0                	test   %eax,%eax
     fc7:	0f 88 af 00 00 00    	js     107c <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     fcd:	83 ec 08             	sub    $0x8,%esp
     fd0:	68 ec 56 00 00       	push   $0x56ec
     fd5:	ff 35 78 6e 00 00    	push   0x6e78
     fdb:	e8 d0 32 00 00       	call   42b0 <printf>
}
     fe0:	83 c4 10             	add    $0x10,%esp
     fe3:	8d 65 f8             	lea    -0x8(%ebp),%esp
     fe6:	5b                   	pop    %ebx
     fe7:	5e                   	pop    %esi
     fe8:	5d                   	pop    %ebp
     fe9:	c3                   	ret
      printf(stdout, "error: write big file failed\n", i);
     fea:	83 ec 04             	sub    $0x4,%esp
     fed:	53                   	push   %ebx
     fee:	68 75 56 00 00       	push   $0x5675
     ff3:	ff 35 78 6e 00 00    	push   0x6e78
     ff9:	e8 b2 32 00 00       	call   42b0 <printf>
      exit();
     ffe:	e8 30 31 00 00       	call   4133 <exit>
      printf(stdout, "read content of block %d is %d\n",
    1003:	50                   	push   %eax
    1004:	56                   	push   %esi
    1005:	68 38 4c 00 00       	push   $0x4c38
    100a:	ff 35 78 6e 00 00    	push   0x6e78
    1010:	e8 9b 32 00 00       	call   42b0 <printf>
      exit();
    1015:	e8 19 31 00 00       	call   4133 <exit>
      printf(stdout, "read failed %d\n", i);
    101a:	83 ec 04             	sub    $0x4,%esp
    101d:	50                   	push   %eax
    101e:	68 c9 56 00 00       	push   $0x56c9
    1023:	ff 35 78 6e 00 00    	push   0x6e78
    1029:	e8 82 32 00 00       	call   42b0 <printf>
      exit();
    102e:	e8 00 31 00 00       	call   4133 <exit>
        printf(stdout, "read only %d blocks from big", n);
    1033:	52                   	push   %edx
    1034:	68 8b 00 00 00       	push   $0x8b
    1039:	68 ac 56 00 00       	push   $0x56ac
    103e:	ff 35 78 6e 00 00    	push   0x6e78
    1044:	e8 67 32 00 00       	call   42b0 <printf>
        exit();
    1049:	e8 e5 30 00 00       	call   4133 <exit>
    printf(stdout, "error: open big failed!\n");
    104e:	51                   	push   %ecx
    104f:	51                   	push   %ecx
    1050:	68 93 56 00 00       	push   $0x5693
    1055:	ff 35 78 6e 00 00    	push   0x6e78
    105b:	e8 50 32 00 00       	call   42b0 <printf>
    exit();
    1060:	e8 ce 30 00 00       	call   4133 <exit>
    printf(stdout, "error: creat big failed!\n");
    1065:	50                   	push   %eax
    1066:	50                   	push   %eax
    1067:	68 5b 56 00 00       	push   $0x565b
    106c:	ff 35 78 6e 00 00    	push   0x6e78
    1072:	e8 39 32 00 00       	call   42b0 <printf>
    exit();
    1077:	e8 b7 30 00 00       	call   4133 <exit>
    printf(stdout, "unlink big failed\n");
    107c:	50                   	push   %eax
    107d:	50                   	push   %eax
    107e:	68 d9 56 00 00       	push   $0x56d9
    1083:	ff 35 78 6e 00 00    	push   0x6e78
    1089:	e8 22 32 00 00       	call   42b0 <printf>
    exit();
    108e:	e8 a0 30 00 00       	call   4133 <exit>
    1093:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    109a:	00 
    109b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000010a0 <createtest>:
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	53                   	push   %ebx
  name[2] = '\0';
    10a4:	bb 30 00 00 00       	mov    $0x30,%ebx
{
    10a9:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
    10ac:	68 58 4c 00 00       	push   $0x4c58
    10b1:	ff 35 78 6e 00 00    	push   0x6e78
    10b7:	e8 f4 31 00 00       	call   42b0 <printf>
  name[0] = 'a';
    10bc:	c6 05 b0 95 00 00 61 	movb   $0x61,0x95b0
  name[2] = '\0';
    10c3:	83 c4 10             	add    $0x10,%esp
    10c6:	c6 05 b2 95 00 00 00 	movb   $0x0,0x95b2
  for(i = 0; i < 52; i++){
    10cd:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
    10d0:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
    10d3:	88 1d b1 95 00 00    	mov    %bl,0x95b1
  for(i = 0; i < 52; i++){
    10d9:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
    10dc:	68 02 02 00 00       	push   $0x202
    10e1:	68 b0 95 00 00       	push   $0x95b0
    10e6:	e8 88 30 00 00       	call   4173 <open>
    close(fd);
    10eb:	89 04 24             	mov    %eax,(%esp)
    10ee:	e8 68 30 00 00       	call   415b <close>
  for(i = 0; i < 52; i++){
    10f3:	83 c4 10             	add    $0x10,%esp
    10f6:	80 fb 64             	cmp    $0x64,%bl
    10f9:	75 d5                	jne    10d0 <createtest+0x30>
  name[0] = 'a';
    10fb:	c6 05 b0 95 00 00 61 	movb   $0x61,0x95b0
  name[2] = '\0';
    1102:	bb 30 00 00 00       	mov    $0x30,%ebx
    1107:	c6 05 b2 95 00 00 00 	movb   $0x0,0x95b2
  for(i = 0; i < 52; i++){
    110e:	66 90                	xchg   %ax,%ax
    unlink(name);
    1110:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
    1113:	88 1d b1 95 00 00    	mov    %bl,0x95b1
  for(i = 0; i < 52; i++){
    1119:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
    111c:	68 b0 95 00 00       	push   $0x95b0
    1121:	e8 5d 30 00 00       	call   4183 <unlink>
  for(i = 0; i < 52; i++){
    1126:	83 c4 10             	add    $0x10,%esp
    1129:	80 fb 64             	cmp    $0x64,%bl
    112c:	75 e2                	jne    1110 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
    112e:	83 ec 08             	sub    $0x8,%esp
    1131:	68 80 4c 00 00       	push   $0x4c80
    1136:	ff 35 78 6e 00 00    	push   0x6e78
    113c:	e8 6f 31 00 00       	call   42b0 <printf>
}
    1141:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1144:	83 c4 10             	add    $0x10,%esp
    1147:	c9                   	leave
    1148:	c3                   	ret
    1149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001150 <dirtest>:
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
    1156:	68 fa 56 00 00       	push   $0x56fa
    115b:	ff 35 78 6e 00 00    	push   0x6e78
    1161:	e8 4a 31 00 00       	call   42b0 <printf>
  if(mkdir("dir0") < 0){
    1166:	c7 04 24 06 57 00 00 	movl   $0x5706,(%esp)
    116d:	e8 29 30 00 00       	call   419b <mkdir>
    1172:	83 c4 10             	add    $0x10,%esp
    1175:	85 c0                	test   %eax,%eax
    1177:	78 58                	js     11d1 <dirtest+0x81>
  if(chdir("dir0") < 0){
    1179:	83 ec 0c             	sub    $0xc,%esp
    117c:	68 06 57 00 00       	push   $0x5706
    1181:	e8 1d 30 00 00       	call   41a3 <chdir>
    1186:	83 c4 10             	add    $0x10,%esp
    1189:	85 c0                	test   %eax,%eax
    118b:	0f 88 85 00 00 00    	js     1216 <dirtest+0xc6>
  if(chdir("..") < 0){
    1191:	83 ec 0c             	sub    $0xc,%esp
    1194:	68 ab 5c 00 00       	push   $0x5cab
    1199:	e8 05 30 00 00       	call   41a3 <chdir>
    119e:	83 c4 10             	add    $0x10,%esp
    11a1:	85 c0                	test   %eax,%eax
    11a3:	78 5a                	js     11ff <dirtest+0xaf>
  if(unlink("dir0") < 0){
    11a5:	83 ec 0c             	sub    $0xc,%esp
    11a8:	68 06 57 00 00       	push   $0x5706
    11ad:	e8 d1 2f 00 00       	call   4183 <unlink>
    11b2:	83 c4 10             	add    $0x10,%esp
    11b5:	85 c0                	test   %eax,%eax
    11b7:	78 2f                	js     11e8 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
    11b9:	83 ec 08             	sub    $0x8,%esp
    11bc:	68 43 57 00 00       	push   $0x5743
    11c1:	ff 35 78 6e 00 00    	push   0x6e78
    11c7:	e8 e4 30 00 00       	call   42b0 <printf>
}
    11cc:	83 c4 10             	add    $0x10,%esp
    11cf:	c9                   	leave
    11d0:	c3                   	ret
    printf(stdout, "mkdir failed\n");
    11d1:	50                   	push   %eax
    11d2:	50                   	push   %eax
    11d3:	68 36 54 00 00       	push   $0x5436
    11d8:	ff 35 78 6e 00 00    	push   0x6e78
    11de:	e8 cd 30 00 00       	call   42b0 <printf>
    exit();
    11e3:	e8 4b 2f 00 00       	call   4133 <exit>
    printf(stdout, "unlink dir0 failed\n");
    11e8:	50                   	push   %eax
    11e9:	50                   	push   %eax
    11ea:	68 2f 57 00 00       	push   $0x572f
    11ef:	ff 35 78 6e 00 00    	push   0x6e78
    11f5:	e8 b6 30 00 00       	call   42b0 <printf>
    exit();
    11fa:	e8 34 2f 00 00       	call   4133 <exit>
    printf(stdout, "chdir .. failed\n");
    11ff:	52                   	push   %edx
    1200:	52                   	push   %edx
    1201:	68 1e 57 00 00       	push   $0x571e
    1206:	ff 35 78 6e 00 00    	push   0x6e78
    120c:	e8 9f 30 00 00       	call   42b0 <printf>
    exit();
    1211:	e8 1d 2f 00 00       	call   4133 <exit>
    printf(stdout, "chdir dir0 failed\n");
    1216:	51                   	push   %ecx
    1217:	51                   	push   %ecx
    1218:	68 0b 57 00 00       	push   $0x570b
    121d:	ff 35 78 6e 00 00    	push   0x6e78
    1223:	e8 88 30 00 00       	call   42b0 <printf>
    exit();
    1228:	e8 06 2f 00 00       	call   4133 <exit>
    122d:	8d 76 00             	lea    0x0(%esi),%esi

00001230 <exectest>:
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
    1236:	68 52 57 00 00       	push   $0x5752
    123b:	ff 35 78 6e 00 00    	push   0x6e78
    1241:	e8 6a 30 00 00       	call   42b0 <printf>
  if(exec("echo", echoargv) < 0){
    1246:	5a                   	pop    %edx
    1247:	59                   	pop    %ecx
    1248:	68 7c 6e 00 00       	push   $0x6e7c
    124d:	68 1b 55 00 00       	push   $0x551b
    1252:	e8 14 2f 00 00       	call   416b <exec>
    1257:	83 c4 10             	add    $0x10,%esp
    125a:	85 c0                	test   %eax,%eax
    125c:	78 02                	js     1260 <exectest+0x30>
}
    125e:	c9                   	leave
    125f:	c3                   	ret
    printf(stdout, "exec echo failed\n");
    1260:	50                   	push   %eax
    1261:	50                   	push   %eax
    1262:	68 5d 57 00 00       	push   $0x575d
    1267:	ff 35 78 6e 00 00    	push   0x6e78
    126d:	e8 3e 30 00 00       	call   42b0 <printf>
    exit();
    1272:	e8 bc 2e 00 00       	call   4133 <exit>
    1277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    127e:	00 
    127f:	90                   	nop

00001280 <pipe1>:
{
    1280:	55                   	push   %ebp
    1281:	89 e5                	mov    %esp,%ebp
    1283:	57                   	push   %edi
    1284:	56                   	push   %esi
  if(pipe(fds) != 0){
    1285:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
    1288:	53                   	push   %ebx
    1289:	83 ec 28             	sub    $0x28,%esp
  if(pipe(fds) != 0){
    128c:	50                   	push   %eax
    128d:	e8 b1 2e 00 00       	call   4143 <pipe>
    1292:	83 c4 10             	add    $0x10,%esp
    1295:	85 c0                	test   %eax,%eax
    1297:	0f 85 41 01 00 00    	jne    13de <pipe1+0x15e>
    129d:	89 c6                	mov    %eax,%esi
  pid = fork();
    129f:	e8 87 2e 00 00       	call   412b <fork>
  if(pid == 0){
    12a4:	85 c0                	test   %eax,%eax
    12a6:	0f 84 92 00 00 00    	je     133e <pipe1+0xbe>
  } else if(pid > 0){
    12ac:	0f 8e 3f 01 00 00    	jle    13f1 <pipe1+0x171>
    close(fds[1]);
    12b2:	83 ec 0c             	sub    $0xc,%esp
    12b5:	ff 75 e4             	push   -0x1c(%ebp)
    total = 0;
    12b8:	31 db                	xor    %ebx,%ebx
    cc = 1;
    12ba:	bf 01 00 00 00       	mov    $0x1,%edi
    close(fds[1]);
    12bf:	e8 97 2e 00 00       	call   415b <close>
    while((n = read(fds[0], buf, cc)) > 0){
    12c4:	83 c4 10             	add    $0x10,%esp
    12c7:	83 ec 04             	sub    $0x4,%esp
    12ca:	57                   	push   %edi
    12cb:	68 c0 95 00 00       	push   $0x95c0
    12d0:	ff 75 e0             	push   -0x20(%ebp)
    12d3:	e8 73 2e 00 00       	call   414b <read>
    12d8:	83 c4 10             	add    $0x10,%esp
    12db:	89 c1                	mov    %eax,%ecx
    12dd:	85 c0                	test   %eax,%eax
    12df:	0f 8e b8 00 00 00    	jle    139d <pipe1+0x11d>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    12e5:	89 f0                	mov    %esi,%eax
    12e7:	32 05 c0 95 00 00    	xor    0x95c0,%al
    12ed:	0f b6 c0             	movzbl %al,%eax
    12f0:	85 c0                	test   %eax,%eax
    12f2:	75 30                	jne    1324 <pipe1+0xa4>
    12f4:	83 c6 01             	add    $0x1,%esi
    12f7:	eb 0f                	jmp    1308 <pipe1+0x88>
    12f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1300:	38 90 c0 95 00 00    	cmp    %dl,0x95c0(%eax)
    1306:	75 1c                	jne    1324 <pipe1+0xa4>
    1308:	8d 14 06             	lea    (%esi,%eax,1),%edx
      for(i = 0; i < n; i++){
    130b:	83 c0 01             	add    $0x1,%eax
    130e:	39 c1                	cmp    %eax,%ecx
    1310:	75 ee                	jne    1300 <pipe1+0x80>
      cc = cc * 2;
    1312:	01 ff                	add    %edi,%edi
      if(cc > sizeof(buf))
    1314:	b8 00 20 00 00       	mov    $0x2000,%eax
      total += n;
    1319:	01 cb                	add    %ecx,%ebx
      if(cc > sizeof(buf))
    131b:	89 d6                	mov    %edx,%esi
    131d:	39 c7                	cmp    %eax,%edi
    131f:	0f 4f f8             	cmovg  %eax,%edi
    1322:	eb a3                	jmp    12c7 <pipe1+0x47>
          printf(1, "pipe1 oops 2\n");
    1324:	83 ec 08             	sub    $0x8,%esp
    1327:	68 8c 57 00 00       	push   $0x578c
    132c:	6a 01                	push   $0x1
    132e:	e8 7d 2f 00 00       	call   42b0 <printf>
    1333:	83 c4 10             	add    $0x10,%esp
}
    1336:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1339:	5b                   	pop    %ebx
    133a:	5e                   	pop    %esi
    133b:	5f                   	pop    %edi
    133c:	5d                   	pop    %ebp
    133d:	c3                   	ret
    close(fds[0]);
    133e:	83 ec 0c             	sub    $0xc,%esp
    1341:	ff 75 e0             	push   -0x20(%ebp)
  seq = 0;
    1344:	31 db                	xor    %ebx,%ebx
    close(fds[0]);
    1346:	e8 10 2e 00 00       	call   415b <close>
    134b:	83 c4 10             	add    $0x10,%esp
    134e:	66 90                	xchg   %ax,%ax
      for(i = 0; i < 1033; i++)
    1350:	31 c0                	xor    %eax,%eax
    1352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        buf[i] = seq++;
    1358:	8d 14 03             	lea    (%ebx,%eax,1),%edx
      for(i = 0; i < 1033; i++)
    135b:	83 c0 01             	add    $0x1,%eax
        buf[i] = seq++;
    135e:	88 90 bf 95 00 00    	mov    %dl,0x95bf(%eax)
      for(i = 0; i < 1033; i++)
    1364:	3d 09 04 00 00       	cmp    $0x409,%eax
    1369:	75 ed                	jne    1358 <pipe1+0xd8>
      if(write(fds[1], buf, 1033) != 1033){
    136b:	83 ec 04             	sub    $0x4,%esp
    136e:	81 c3 09 04 00 00    	add    $0x409,%ebx
    1374:	68 09 04 00 00       	push   $0x409
    1379:	68 c0 95 00 00       	push   $0x95c0
    137e:	ff 75 e4             	push   -0x1c(%ebp)
    1381:	e8 cd 2d 00 00       	call   4153 <write>
    1386:	83 c4 10             	add    $0x10,%esp
    1389:	3d 09 04 00 00       	cmp    $0x409,%eax
    138e:	75 74                	jne    1404 <pipe1+0x184>
    for(n = 0; n < 5; n++){
    1390:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
    1396:	75 b8                	jne    1350 <pipe1+0xd0>
    exit();
    1398:	e8 96 2d 00 00       	call   4133 <exit>
    if(total != 5 * 1033){
    139d:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
    13a3:	75 26                	jne    13cb <pipe1+0x14b>
    close(fds[0]);
    13a5:	83 ec 0c             	sub    $0xc,%esp
    13a8:	ff 75 e0             	push   -0x20(%ebp)
    13ab:	e8 ab 2d 00 00       	call   415b <close>
    wait();
    13b0:	e8 86 2d 00 00       	call   413b <wait>
  printf(1, "pipe1 ok\n");
    13b5:	5a                   	pop    %edx
    13b6:	59                   	pop    %ecx
    13b7:	68 b1 57 00 00       	push   $0x57b1
    13bc:	6a 01                	push   $0x1
    13be:	e8 ed 2e 00 00       	call   42b0 <printf>
    13c3:	83 c4 10             	add    $0x10,%esp
    13c6:	e9 6b ff ff ff       	jmp    1336 <pipe1+0xb6>
      printf(1, "pipe1 oops 3 total %d\n", total);
    13cb:	56                   	push   %esi
    13cc:	53                   	push   %ebx
    13cd:	68 9a 57 00 00       	push   $0x579a
    13d2:	6a 01                	push   $0x1
    13d4:	e8 d7 2e 00 00       	call   42b0 <printf>
      exit();
    13d9:	e8 55 2d 00 00       	call   4133 <exit>
    printf(1, "pipe() failed\n");
    13de:	50                   	push   %eax
    13df:	50                   	push   %eax
    13e0:	68 6f 57 00 00       	push   $0x576f
    13e5:	6a 01                	push   $0x1
    13e7:	e8 c4 2e 00 00       	call   42b0 <printf>
    exit();
    13ec:	e8 42 2d 00 00       	call   4133 <exit>
    printf(1, "fork() failed\n");
    13f1:	50                   	push   %eax
    13f2:	50                   	push   %eax
    13f3:	68 bb 57 00 00       	push   $0x57bb
    13f8:	6a 01                	push   $0x1
    13fa:	e8 b1 2e 00 00       	call   42b0 <printf>
    exit();
    13ff:	e8 2f 2d 00 00       	call   4133 <exit>
        printf(1, "pipe1 oops 1\n");
    1404:	57                   	push   %edi
    1405:	57                   	push   %edi
    1406:	68 7e 57 00 00       	push   $0x577e
    140b:	6a 01                	push   $0x1
    140d:	e8 9e 2e 00 00       	call   42b0 <printf>
        exit();
    1412:	e8 1c 2d 00 00       	call   4133 <exit>
    1417:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    141e:	00 
    141f:	90                   	nop

00001420 <preempt>:
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	57                   	push   %edi
    1424:	56                   	push   %esi
    1425:	53                   	push   %ebx
    1426:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
    1429:	68 ca 57 00 00       	push   $0x57ca
    142e:	6a 01                	push   $0x1
    1430:	e8 7b 2e 00 00       	call   42b0 <printf>
  pid1 = fork();
    1435:	e8 f1 2c 00 00       	call   412b <fork>
  if(pid1 == 0)
    143a:	83 c4 10             	add    $0x10,%esp
    143d:	85 c0                	test   %eax,%eax
    143f:	75 07                	jne    1448 <preempt+0x28>
    for(;;)
    1441:	eb fe                	jmp    1441 <preempt+0x21>
    1443:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1448:	89 c3                	mov    %eax,%ebx
  pid2 = fork();
    144a:	e8 dc 2c 00 00       	call   412b <fork>
    144f:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
    1451:	85 c0                	test   %eax,%eax
    1453:	75 0b                	jne    1460 <preempt+0x40>
    for(;;)
    1455:	eb fe                	jmp    1455 <preempt+0x35>
    1457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    145e:	00 
    145f:	90                   	nop
  pipe(pfds);
    1460:	83 ec 0c             	sub    $0xc,%esp
    1463:	8d 45 e0             	lea    -0x20(%ebp),%eax
    1466:	50                   	push   %eax
    1467:	e8 d7 2c 00 00       	call   4143 <pipe>
  pid3 = fork();
    146c:	e8 ba 2c 00 00       	call   412b <fork>
  if(pid3 == 0){
    1471:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
    1474:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
    1476:	85 c0                	test   %eax,%eax
    1478:	75 3e                	jne    14b8 <preempt+0x98>
    close(pfds[0]);
    147a:	83 ec 0c             	sub    $0xc,%esp
    147d:	ff 75 e0             	push   -0x20(%ebp)
    1480:	e8 d6 2c 00 00       	call   415b <close>
    if(write(pfds[1], "x", 1) != 1)
    1485:	83 c4 0c             	add    $0xc,%esp
    1488:	6a 01                	push   $0x1
    148a:	68 8f 5d 00 00       	push   $0x5d8f
    148f:	ff 75 e4             	push   -0x1c(%ebp)
    1492:	e8 bc 2c 00 00       	call   4153 <write>
    1497:	83 c4 10             	add    $0x10,%esp
    149a:	83 f8 01             	cmp    $0x1,%eax
    149d:	0f 85 b8 00 00 00    	jne    155b <preempt+0x13b>
    close(pfds[1]);
    14a3:	83 ec 0c             	sub    $0xc,%esp
    14a6:	ff 75 e4             	push   -0x1c(%ebp)
    14a9:	e8 ad 2c 00 00       	call   415b <close>
    14ae:	83 c4 10             	add    $0x10,%esp
    for(;;)
    14b1:	eb fe                	jmp    14b1 <preempt+0x91>
    14b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  close(pfds[1]);
    14b8:	83 ec 0c             	sub    $0xc,%esp
    14bb:	ff 75 e4             	push   -0x1c(%ebp)
    14be:	e8 98 2c 00 00       	call   415b <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    14c3:	83 c4 0c             	add    $0xc,%esp
    14c6:	68 00 20 00 00       	push   $0x2000
    14cb:	68 c0 95 00 00       	push   $0x95c0
    14d0:	ff 75 e0             	push   -0x20(%ebp)
    14d3:	e8 73 2c 00 00       	call   414b <read>
    14d8:	83 c4 10             	add    $0x10,%esp
    14db:	83 f8 01             	cmp    $0x1,%eax
    14de:	75 67                	jne    1547 <preempt+0x127>
  close(pfds[0]);
    14e0:	83 ec 0c             	sub    $0xc,%esp
    14e3:	ff 75 e0             	push   -0x20(%ebp)
    14e6:	e8 70 2c 00 00       	call   415b <close>
  printf(1, "kill... ");
    14eb:	58                   	pop    %eax
    14ec:	5a                   	pop    %edx
    14ed:	68 fb 57 00 00       	push   $0x57fb
    14f2:	6a 01                	push   $0x1
    14f4:	e8 b7 2d 00 00       	call   42b0 <printf>
  kill(pid1);
    14f9:	89 1c 24             	mov    %ebx,(%esp)
    14fc:	e8 62 2c 00 00       	call   4163 <kill>
  kill(pid2);
    1501:	89 34 24             	mov    %esi,(%esp)
    1504:	e8 5a 2c 00 00       	call   4163 <kill>
  kill(pid3);
    1509:	89 3c 24             	mov    %edi,(%esp)
    150c:	e8 52 2c 00 00       	call   4163 <kill>
  printf(1, "wait... ");
    1511:	59                   	pop    %ecx
    1512:	5b                   	pop    %ebx
    1513:	68 04 58 00 00       	push   $0x5804
    1518:	6a 01                	push   $0x1
    151a:	e8 91 2d 00 00       	call   42b0 <printf>
  wait();
    151f:	e8 17 2c 00 00       	call   413b <wait>
  wait();
    1524:	e8 12 2c 00 00       	call   413b <wait>
  wait();
    1529:	e8 0d 2c 00 00       	call   413b <wait>
  printf(1, "preempt ok\n");
    152e:	5e                   	pop    %esi
    152f:	5f                   	pop    %edi
    1530:	68 0d 58 00 00       	push   $0x580d
    1535:	6a 01                	push   $0x1
    1537:	e8 74 2d 00 00       	call   42b0 <printf>
    153c:	83 c4 10             	add    $0x10,%esp
}
    153f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1542:	5b                   	pop    %ebx
    1543:	5e                   	pop    %esi
    1544:	5f                   	pop    %edi
    1545:	5d                   	pop    %ebp
    1546:	c3                   	ret
    printf(1, "preempt read error");
    1547:	83 ec 08             	sub    $0x8,%esp
    154a:	68 e8 57 00 00       	push   $0x57e8
    154f:	6a 01                	push   $0x1
    1551:	e8 5a 2d 00 00       	call   42b0 <printf>
    1556:	83 c4 10             	add    $0x10,%esp
    1559:	eb e4                	jmp    153f <preempt+0x11f>
      printf(1, "preempt write error");
    155b:	83 ec 08             	sub    $0x8,%esp
    155e:	68 d4 57 00 00       	push   $0x57d4
    1563:	6a 01                	push   $0x1
    1565:	e8 46 2d 00 00       	call   42b0 <printf>
    156a:	83 c4 10             	add    $0x10,%esp
    156d:	e9 31 ff ff ff       	jmp    14a3 <preempt+0x83>
    1572:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1579:	00 
    157a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001580 <exitwait>:
{
    1580:	55                   	push   %ebp
    1581:	89 e5                	mov    %esp,%ebp
    1583:	56                   	push   %esi
    1584:	be 64 00 00 00       	mov    $0x64,%esi
    1589:	53                   	push   %ebx
    158a:	eb 14                	jmp    15a0 <exitwait+0x20>
    158c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
    1590:	74 68                	je     15fa <exitwait+0x7a>
      if(wait() != pid){
    1592:	e8 a4 2b 00 00       	call   413b <wait>
    1597:	39 d8                	cmp    %ebx,%eax
    1599:	75 2d                	jne    15c8 <exitwait+0x48>
  for(i = 0; i < 100; i++){
    159b:	83 ee 01             	sub    $0x1,%esi
    159e:	74 41                	je     15e1 <exitwait+0x61>
    pid = fork();
    15a0:	e8 86 2b 00 00       	call   412b <fork>
    15a5:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    15a7:	85 c0                	test   %eax,%eax
    15a9:	79 e5                	jns    1590 <exitwait+0x10>
      printf(1, "fork failed\n");
    15ab:	83 ec 08             	sub    $0x8,%esp
    15ae:	68 77 63 00 00       	push   $0x6377
    15b3:	6a 01                	push   $0x1
    15b5:	e8 f6 2c 00 00       	call   42b0 <printf>
      return;
    15ba:	83 c4 10             	add    $0x10,%esp
}
    15bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
    15c0:	5b                   	pop    %ebx
    15c1:	5e                   	pop    %esi
    15c2:	5d                   	pop    %ebp
    15c3:	c3                   	ret
    15c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
    15c8:	83 ec 08             	sub    $0x8,%esp
    15cb:	68 19 58 00 00       	push   $0x5819
    15d0:	6a 01                	push   $0x1
    15d2:	e8 d9 2c 00 00       	call   42b0 <printf>
        return;
    15d7:	83 c4 10             	add    $0x10,%esp
}
    15da:	8d 65 f8             	lea    -0x8(%ebp),%esp
    15dd:	5b                   	pop    %ebx
    15de:	5e                   	pop    %esi
    15df:	5d                   	pop    %ebp
    15e0:	c3                   	ret
  printf(1, "exitwait ok\n");
    15e1:	83 ec 08             	sub    $0x8,%esp
    15e4:	68 29 58 00 00       	push   $0x5829
    15e9:	6a 01                	push   $0x1
    15eb:	e8 c0 2c 00 00       	call   42b0 <printf>
    15f0:	83 c4 10             	add    $0x10,%esp
}
    15f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
    15f6:	5b                   	pop    %ebx
    15f7:	5e                   	pop    %esi
    15f8:	5d                   	pop    %ebp
    15f9:	c3                   	ret
      exit();
    15fa:	e8 34 2b 00 00       	call   4133 <exit>
    15ff:	90                   	nop

00001600 <mem>:
{
    1600:	55                   	push   %ebp
    1601:	89 e5                	mov    %esp,%ebp
    1603:	56                   	push   %esi
    1604:	31 f6                	xor    %esi,%esi
    1606:	53                   	push   %ebx
  printf(1, "mem test\n");
    1607:	83 ec 08             	sub    $0x8,%esp
    160a:	68 36 58 00 00       	push   $0x5836
    160f:	6a 01                	push   $0x1
    1611:	e8 9a 2c 00 00       	call   42b0 <printf>
  ppid = getpid();
    1616:	e8 98 2b 00 00       	call   41b3 <getpid>
    161b:	89 c3                	mov    %eax,%ebx
  if((pid = fork()) == 0){
    161d:	e8 09 2b 00 00       	call   412b <fork>
    1622:	83 c4 10             	add    $0x10,%esp
    1625:	85 c0                	test   %eax,%eax
    1627:	74 0b                	je     1634 <mem+0x34>
    1629:	e9 8a 00 00 00       	jmp    16b8 <mem+0xb8>
    162e:	66 90                	xchg   %ax,%ax
      *(char**)m2 = m1;
    1630:	89 30                	mov    %esi,(%eax)
      m1 = m2;
    1632:	89 c6                	mov    %eax,%esi
    while((m2 = malloc(10001)) != 0){
    1634:	83 ec 0c             	sub    $0xc,%esp
    1637:	68 11 27 00 00       	push   $0x2711
    163c:	e8 8f 2e 00 00       	call   44d0 <malloc>
    1641:	83 c4 10             	add    $0x10,%esp
    1644:	85 c0                	test   %eax,%eax
    1646:	75 e8                	jne    1630 <mem+0x30>
    while(m1){
    1648:	85 f6                	test   %esi,%esi
    164a:	74 18                	je     1664 <mem+0x64>
    164c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
    1650:	89 f0                	mov    %esi,%eax
      free(m1);
    1652:	83 ec 0c             	sub    $0xc,%esp
      m2 = *(char**)m1;
    1655:	8b 36                	mov    (%esi),%esi
      free(m1);
    1657:	50                   	push   %eax
    1658:	e8 e3 2d 00 00       	call   4440 <free>
    while(m1){
    165d:	83 c4 10             	add    $0x10,%esp
    1660:	85 f6                	test   %esi,%esi
    1662:	75 ec                	jne    1650 <mem+0x50>
    m1 = malloc(1024*20);
    1664:	83 ec 0c             	sub    $0xc,%esp
    1667:	68 00 50 00 00       	push   $0x5000
    166c:	e8 5f 2e 00 00       	call   44d0 <malloc>
    if(m1 == 0){
    1671:	83 c4 10             	add    $0x10,%esp
    1674:	85 c0                	test   %eax,%eax
    1676:	74 20                	je     1698 <mem+0x98>
    free(m1);
    1678:	83 ec 0c             	sub    $0xc,%esp
    167b:	50                   	push   %eax
    167c:	e8 bf 2d 00 00       	call   4440 <free>
    printf(1, "mem ok\n");
    1681:	58                   	pop    %eax
    1682:	5a                   	pop    %edx
    1683:	68 5a 58 00 00       	push   $0x585a
    1688:	6a 01                	push   $0x1
    168a:	e8 21 2c 00 00       	call   42b0 <printf>
    exit();
    168f:	e8 9f 2a 00 00       	call   4133 <exit>
    1694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
    1698:	83 ec 08             	sub    $0x8,%esp
    169b:	68 40 58 00 00       	push   $0x5840
    16a0:	6a 01                	push   $0x1
    16a2:	e8 09 2c 00 00       	call   42b0 <printf>
      kill(ppid);
    16a7:	89 1c 24             	mov    %ebx,(%esp)
    16aa:	e8 b4 2a 00 00       	call   4163 <kill>
      exit();
    16af:	e8 7f 2a 00 00       	call   4133 <exit>
    16b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
    16b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    16bb:	5b                   	pop    %ebx
    16bc:	5e                   	pop    %esi
    16bd:	5d                   	pop    %ebp
    wait();
    16be:	e9 78 2a 00 00       	jmp    413b <wait>
    16c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    16ca:	00 
    16cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000016d0 <sharedfd>:
{
    16d0:	55                   	push   %ebp
    16d1:	89 e5                	mov    %esp,%ebp
    16d3:	57                   	push   %edi
    16d4:	56                   	push   %esi
    16d5:	53                   	push   %ebx
    16d6:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
    16d9:	68 62 58 00 00       	push   $0x5862
    16de:	6a 01                	push   $0x1
    16e0:	e8 cb 2b 00 00       	call   42b0 <printf>
  unlink("sharedfd");
    16e5:	c7 04 24 71 58 00 00 	movl   $0x5871,(%esp)
    16ec:	e8 92 2a 00 00       	call   4183 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    16f1:	5b                   	pop    %ebx
    16f2:	5e                   	pop    %esi
    16f3:	68 02 02 00 00       	push   $0x202
    16f8:	68 71 58 00 00       	push   $0x5871
    16fd:	e8 71 2a 00 00       	call   4173 <open>
  if(fd < 0){
    1702:	83 c4 10             	add    $0x10,%esp
    1705:	85 c0                	test   %eax,%eax
    1707:	0f 88 2a 01 00 00    	js     1837 <sharedfd+0x167>
    170d:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
    170f:	8d 75 de             	lea    -0x22(%ebp),%esi
    1712:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
    1717:	e8 0f 2a 00 00       	call   412b <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    171c:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
    171f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    1722:	19 c0                	sbb    %eax,%eax
    1724:	83 ec 04             	sub    $0x4,%esp
    1727:	83 e0 f3             	and    $0xfffffff3,%eax
    172a:	6a 0a                	push   $0xa
    172c:	83 c0 70             	add    $0x70,%eax
    172f:	50                   	push   %eax
    1730:	56                   	push   %esi
    1731:	e8 7a 28 00 00       	call   3fb0 <memset>
    1736:	83 c4 10             	add    $0x10,%esp
    1739:	eb 0a                	jmp    1745 <sharedfd+0x75>
    173b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
    1740:	83 eb 01             	sub    $0x1,%ebx
    1743:	74 26                	je     176b <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    1745:	83 ec 04             	sub    $0x4,%esp
    1748:	6a 0a                	push   $0xa
    174a:	56                   	push   %esi
    174b:	57                   	push   %edi
    174c:	e8 02 2a 00 00       	call   4153 <write>
    1751:	83 c4 10             	add    $0x10,%esp
    1754:	83 f8 0a             	cmp    $0xa,%eax
    1757:	74 e7                	je     1740 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
    1759:	83 ec 08             	sub    $0x8,%esp
    175c:	68 d4 4c 00 00       	push   $0x4cd4
    1761:	6a 01                	push   $0x1
    1763:	e8 48 2b 00 00       	call   42b0 <printf>
      break;
    1768:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
    176b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    176e:	85 c9                	test   %ecx,%ecx
    1770:	0f 84 f5 00 00 00    	je     186b <sharedfd+0x19b>
    wait();
    1776:	e8 c0 29 00 00       	call   413b <wait>
  close(fd);
    177b:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
    177e:	31 db                	xor    %ebx,%ebx
  close(fd);
    1780:	57                   	push   %edi
    1781:	8d 7d e8             	lea    -0x18(%ebp),%edi
    1784:	e8 d2 29 00 00       	call   415b <close>
  fd = open("sharedfd", 0);
    1789:	58                   	pop    %eax
    178a:	5a                   	pop    %edx
    178b:	6a 00                	push   $0x0
    178d:	68 71 58 00 00       	push   $0x5871
    1792:	e8 dc 29 00 00       	call   4173 <open>
  if(fd < 0){
    1797:	83 c4 10             	add    $0x10,%esp
  nc = np = 0;
    179a:	31 d2                	xor    %edx,%edx
  fd = open("sharedfd", 0);
    179c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
    179f:	85 c0                	test   %eax,%eax
    17a1:	0f 88 aa 00 00 00    	js     1851 <sharedfd+0x181>
    17a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    17ae:	00 
    17af:	90                   	nop
  while((n = read(fd, buf, sizeof(buf))) > 0){
    17b0:	83 ec 04             	sub    $0x4,%esp
    17b3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    17b6:	6a 0a                	push   $0xa
    17b8:	56                   	push   %esi
    17b9:	ff 75 d0             	push   -0x30(%ebp)
    17bc:	e8 8a 29 00 00       	call   414b <read>
    17c1:	83 c4 10             	add    $0x10,%esp
    17c4:	85 c0                	test   %eax,%eax
    17c6:	7e 28                	jle    17f0 <sharedfd+0x120>
    17c8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    17cb:	89 f0                	mov    %esi,%eax
    17cd:	eb 13                	jmp    17e2 <sharedfd+0x112>
    17cf:	90                   	nop
        np++;
    17d0:	80 f9 70             	cmp    $0x70,%cl
    17d3:	0f 94 c1             	sete   %cl
    17d6:	0f b6 c9             	movzbl %cl,%ecx
    17d9:	01 cb                	add    %ecx,%ebx
    for(i = 0; i < sizeof(buf); i++){
    17db:	83 c0 01             	add    $0x1,%eax
    17de:	39 c7                	cmp    %eax,%edi
    17e0:	74 ce                	je     17b0 <sharedfd+0xe0>
      if(buf[i] == 'c')
    17e2:	0f b6 08             	movzbl (%eax),%ecx
    17e5:	80 f9 63             	cmp    $0x63,%cl
    17e8:	75 e6                	jne    17d0 <sharedfd+0x100>
        nc++;
    17ea:	83 c2 01             	add    $0x1,%edx
      if(buf[i] == 'p')
    17ed:	eb ec                	jmp    17db <sharedfd+0x10b>
    17ef:	90                   	nop
  close(fd);
    17f0:	83 ec 0c             	sub    $0xc,%esp
    17f3:	ff 75 d0             	push   -0x30(%ebp)
    17f6:	e8 60 29 00 00       	call   415b <close>
  unlink("sharedfd");
    17fb:	c7 04 24 71 58 00 00 	movl   $0x5871,(%esp)
    1802:	e8 7c 29 00 00       	call   4183 <unlink>
  if(nc == 10000 && np == 10000){
    1807:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    180a:	83 c4 10             	add    $0x10,%esp
    180d:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
    1813:	75 5b                	jne    1870 <sharedfd+0x1a0>
    1815:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    181b:	75 53                	jne    1870 <sharedfd+0x1a0>
    printf(1, "sharedfd ok\n");
    181d:	83 ec 08             	sub    $0x8,%esp
    1820:	68 7a 58 00 00       	push   $0x587a
    1825:	6a 01                	push   $0x1
    1827:	e8 84 2a 00 00       	call   42b0 <printf>
    182c:	83 c4 10             	add    $0x10,%esp
}
    182f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1832:	5b                   	pop    %ebx
    1833:	5e                   	pop    %esi
    1834:	5f                   	pop    %edi
    1835:	5d                   	pop    %ebp
    1836:	c3                   	ret
    printf(1, "fstests: cannot open sharedfd for writing");
    1837:	83 ec 08             	sub    $0x8,%esp
    183a:	68 a8 4c 00 00       	push   $0x4ca8
    183f:	6a 01                	push   $0x1
    1841:	e8 6a 2a 00 00       	call   42b0 <printf>
    return;
    1846:	83 c4 10             	add    $0x10,%esp
}
    1849:	8d 65 f4             	lea    -0xc(%ebp),%esp
    184c:	5b                   	pop    %ebx
    184d:	5e                   	pop    %esi
    184e:	5f                   	pop    %edi
    184f:	5d                   	pop    %ebp
    1850:	c3                   	ret
    printf(1, "fstests: cannot open sharedfd for reading\n");
    1851:	83 ec 08             	sub    $0x8,%esp
    1854:	68 f4 4c 00 00       	push   $0x4cf4
    1859:	6a 01                	push   $0x1
    185b:	e8 50 2a 00 00       	call   42b0 <printf>
    return;
    1860:	83 c4 10             	add    $0x10,%esp
}
    1863:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1866:	5b                   	pop    %ebx
    1867:	5e                   	pop    %esi
    1868:	5f                   	pop    %edi
    1869:	5d                   	pop    %ebp
    186a:	c3                   	ret
    exit();
    186b:	e8 c3 28 00 00       	call   4133 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1870:	53                   	push   %ebx
    1871:	52                   	push   %edx
    1872:	68 87 58 00 00       	push   $0x5887
    1877:	6a 01                	push   $0x1
    1879:	e8 32 2a 00 00       	call   42b0 <printf>
    exit();
    187e:	e8 b0 28 00 00       	call   4133 <exit>
    1883:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    188a:	00 
    188b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00001890 <fourfiles>:
{
    1890:	55                   	push   %ebp
    1891:	89 e5                	mov    %esp,%ebp
    1893:	57                   	push   %edi
    1894:	56                   	push   %esi
    1895:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1896:	31 db                	xor    %ebx,%ebx
{
    1898:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
    189b:	c7 45 d8 9c 58 00 00 	movl   $0x589c,-0x28(%ebp)
    18a2:	c7 45 dc e5 59 00 00 	movl   $0x59e5,-0x24(%ebp)
    18a9:	c7 45 e0 e9 59 00 00 	movl   $0x59e9,-0x20(%ebp)
    18b0:	c7 45 e4 9f 58 00 00 	movl   $0x589f,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    18b7:	68 a2 58 00 00       	push   $0x58a2
    18bc:	6a 01                	push   $0x1
    18be:	e8 ed 29 00 00       	call   42b0 <printf>
    18c3:	83 c4 10             	add    $0x10,%esp
    fname = names[pi];
    18c6:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    unlink(fname);
    18ca:	83 ec 0c             	sub    $0xc,%esp
    18cd:	56                   	push   %esi
    18ce:	e8 b0 28 00 00       	call   4183 <unlink>
    pid = fork();
    18d3:	e8 53 28 00 00       	call   412b <fork>
    if(pid < 0){
    18d8:	83 c4 10             	add    $0x10,%esp
    18db:	85 c0                	test   %eax,%eax
    18dd:	0f 88 6d 01 00 00    	js     1a50 <fourfiles+0x1c0>
    if(pid == 0){
    18e3:	0f 84 f0 00 00 00    	je     19d9 <fourfiles+0x149>
  for(pi = 0; pi < 4; pi++){
    18e9:	83 c3 01             	add    $0x1,%ebx
    18ec:	83 fb 04             	cmp    $0x4,%ebx
    18ef:	75 d5                	jne    18c6 <fourfiles+0x36>
    wait();
    18f1:	e8 45 28 00 00       	call   413b <wait>
    18f6:	31 f6                	xor    %esi,%esi
    18f8:	e8 3e 28 00 00       	call   413b <wait>
    18fd:	e8 39 28 00 00       	call   413b <wait>
    1902:	e8 34 28 00 00       	call   413b <wait>
    fname = names[i];
    1907:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    fd = open(fname, 0);
    190b:	83 ec 08             	sub    $0x8,%esp
    190e:	89 f3                	mov    %esi,%ebx
    total = 0;
    1910:	31 ff                	xor    %edi,%edi
    1912:	83 f3 01             	xor    $0x1,%ebx
    fname = names[i];
    1915:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    1918:	6a 00                	push   $0x0
    191a:	50                   	push   %eax
    191b:	e8 53 28 00 00       	call   4173 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1920:	83 c4 10             	add    $0x10,%esp
    1923:	89 75 cc             	mov    %esi,-0x34(%ebp)
    1926:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1930:	83 ec 04             	sub    $0x4,%esp
    1933:	68 00 20 00 00       	push   $0x2000
    1938:	68 c0 95 00 00       	push   $0x95c0
    193d:	ff 75 d4             	push   -0x2c(%ebp)
    1940:	e8 06 28 00 00       	call   414b <read>
    1945:	83 c4 10             	add    $0x10,%esp
    1948:	89 c6                	mov    %eax,%esi
    194a:	85 c0                	test   %eax,%eax
    194c:	7e 23                	jle    1971 <fourfiles+0xe1>
      for(j = 0; j < n; j++){
    194e:	31 d2                	xor    %edx,%edx
        if(buf[j] != '0'+i){
    1950:	89 d8                	mov    %ebx,%eax
    1952:	0f be 8a c0 95 00 00 	movsbl 0x95c0(%edx),%ecx
    1959:	c1 e0 1f             	shl    $0x1f,%eax
    195c:	c1 f8 1f             	sar    $0x1f,%eax
    195f:	83 c0 31             	add    $0x31,%eax
    1962:	39 c1                	cmp    %eax,%ecx
    1964:	75 5f                	jne    19c5 <fourfiles+0x135>
      for(j = 0; j < n; j++){
    1966:	83 c2 01             	add    $0x1,%edx
    1969:	39 d6                	cmp    %edx,%esi
    196b:	75 e3                	jne    1950 <fourfiles+0xc0>
      total += n;
    196d:	01 f7                	add    %esi,%edi
    196f:	eb bf                	jmp    1930 <fourfiles+0xa0>
    close(fd);
    1971:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
    1974:	83 ec 0c             	sub    $0xc,%esp
    1977:	8b 75 cc             	mov    -0x34(%ebp),%esi
    197a:	51                   	push   %ecx
    197b:	e8 db 27 00 00       	call   415b <close>
    if(total != 12*500){
    1980:	83 c4 10             	add    $0x10,%esp
    1983:	81 ff 70 17 00 00    	cmp    $0x1770,%edi
    1989:	0f 85 d5 00 00 00    	jne    1a64 <fourfiles+0x1d4>
    unlink(fname);
    198f:	83 ec 0c             	sub    $0xc,%esp
    1992:	ff 75 d0             	push   -0x30(%ebp)
    1995:	e8 e9 27 00 00       	call   4183 <unlink>
  for(i = 0; i < 2; i++){
    199a:	83 c4 10             	add    $0x10,%esp
    199d:	85 f6                	test   %esi,%esi
    199f:	75 0a                	jne    19ab <fourfiles+0x11b>
    19a1:	be 01 00 00 00       	mov    $0x1,%esi
    19a6:	e9 5c ff ff ff       	jmp    1907 <fourfiles+0x77>
  printf(1, "fourfiles ok\n");
    19ab:	83 ec 08             	sub    $0x8,%esp
    19ae:	68 e0 58 00 00       	push   $0x58e0
    19b3:	6a 01                	push   $0x1
    19b5:	e8 f6 28 00 00       	call   42b0 <printf>
}
    19ba:	83 c4 10             	add    $0x10,%esp
    19bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19c0:	5b                   	pop    %ebx
    19c1:	5e                   	pop    %esi
    19c2:	5f                   	pop    %edi
    19c3:	5d                   	pop    %ebp
    19c4:	c3                   	ret
          printf(1, "wrong char\n");
    19c5:	83 ec 08             	sub    $0x8,%esp
    19c8:	68 c3 58 00 00       	push   $0x58c3
    19cd:	6a 01                	push   $0x1
    19cf:	e8 dc 28 00 00       	call   42b0 <printf>
          exit();
    19d4:	e8 5a 27 00 00       	call   4133 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    19d9:	83 ec 08             	sub    $0x8,%esp
    19dc:	68 02 02 00 00       	push   $0x202
    19e1:	56                   	push   %esi
    19e2:	e8 8c 27 00 00       	call   4173 <open>
      if(fd < 0){
    19e7:	83 c4 10             	add    $0x10,%esp
      fd = open(fname, O_CREATE | O_RDWR);
    19ea:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    19ec:	85 c0                	test   %eax,%eax
    19ee:	78 45                	js     1a35 <fourfiles+0x1a5>
      memset(buf, '0'+pi, 512);
    19f0:	83 ec 04             	sub    $0x4,%esp
    19f3:	83 c3 30             	add    $0x30,%ebx
    19f6:	68 00 02 00 00       	push   $0x200
    19fb:	53                   	push   %ebx
    19fc:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1a01:	68 c0 95 00 00       	push   $0x95c0
    1a06:	e8 a5 25 00 00       	call   3fb0 <memset>
    1a0b:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    1a0e:	83 ec 04             	sub    $0x4,%esp
    1a11:	68 f4 01 00 00       	push   $0x1f4
    1a16:	68 c0 95 00 00       	push   $0x95c0
    1a1b:	56                   	push   %esi
    1a1c:	e8 32 27 00 00       	call   4153 <write>
    1a21:	83 c4 10             	add    $0x10,%esp
    1a24:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1a29:	75 4c                	jne    1a77 <fourfiles+0x1e7>
      for(i = 0; i < 12; i++){
    1a2b:	83 eb 01             	sub    $0x1,%ebx
    1a2e:	75 de                	jne    1a0e <fourfiles+0x17e>
      exit();
    1a30:	e8 fe 26 00 00       	call   4133 <exit>
        printf(1, "create failed\n");
    1a35:	51                   	push   %ecx
    1a36:	51                   	push   %ecx
    1a37:	68 3d 5b 00 00       	push   $0x5b3d
    1a3c:	6a 01                	push   $0x1
    1a3e:	e8 6d 28 00 00       	call   42b0 <printf>
        exit();
    1a43:	e8 eb 26 00 00       	call   4133 <exit>
    1a48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1a4f:	00 
      printf(1, "fork failed\n");
    1a50:	83 ec 08             	sub    $0x8,%esp
    1a53:	68 77 63 00 00       	push   $0x6377
    1a58:	6a 01                	push   $0x1
    1a5a:	e8 51 28 00 00       	call   42b0 <printf>
      exit();
    1a5f:	e8 cf 26 00 00       	call   4133 <exit>
      printf(1, "wrong length %d\n", total);
    1a64:	50                   	push   %eax
    1a65:	57                   	push   %edi
    1a66:	68 cf 58 00 00       	push   $0x58cf
    1a6b:	6a 01                	push   $0x1
    1a6d:	e8 3e 28 00 00       	call   42b0 <printf>
      exit();
    1a72:	e8 bc 26 00 00       	call   4133 <exit>
          printf(1, "write failed %d\n", n);
    1a77:	52                   	push   %edx
    1a78:	50                   	push   %eax
    1a79:	68 b2 58 00 00       	push   $0x58b2
    1a7e:	6a 01                	push   $0x1
    1a80:	e8 2b 28 00 00       	call   42b0 <printf>
          exit();
    1a85:	e8 a9 26 00 00       	call   4133 <exit>
    1a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001a90 <createdelete>:
{
    1a90:	55                   	push   %ebp
    1a91:	89 e5                	mov    %esp,%ebp
    1a93:	57                   	push   %edi
    1a94:	56                   	push   %esi
  for(pi = 0; pi < 4; pi++){
    1a95:	31 f6                	xor    %esi,%esi
{
    1a97:	53                   	push   %ebx
    1a98:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    1a9b:	68 ee 58 00 00       	push   $0x58ee
    1aa0:	6a 01                	push   $0x1
    1aa2:	e8 09 28 00 00       	call   42b0 <printf>
    1aa7:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    1aaa:	e8 7c 26 00 00       	call   412b <fork>
    1aaf:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    1ab1:	85 c0                	test   %eax,%eax
    1ab3:	0f 88 ac 01 00 00    	js     1c65 <createdelete+0x1d5>
    if(pid == 0){
    1ab9:	0f 84 01 01 00 00    	je     1bc0 <createdelete+0x130>
  for(pi = 0; pi < 4; pi++){
    1abf:	83 c6 01             	add    $0x1,%esi
    1ac2:	83 fe 04             	cmp    $0x4,%esi
    1ac5:	75 e3                	jne    1aaa <createdelete+0x1a>
    wait();
    1ac7:	e8 6f 26 00 00       	call   413b <wait>
  for(i = 0; i < N; i++){
    1acc:	31 ff                	xor    %edi,%edi
    1ace:	8d 75 c8             	lea    -0x38(%ebp),%esi
    wait();
    1ad1:	e8 65 26 00 00       	call   413b <wait>
    1ad6:	e8 60 26 00 00       	call   413b <wait>
    1adb:	e8 5b 26 00 00       	call   413b <wait>
  name[0] = name[1] = name[2] = 0;
    1ae0:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    1ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((i == 0 || i >= N/2) && fd < 0){
    1ae8:	85 ff                	test   %edi,%edi
      name[1] = '0' + i;
    1aea:	8d 47 30             	lea    0x30(%edi),%eax
      if((i == 0 || i >= N/2) && fd < 0){
    1aed:	bb 70 00 00 00       	mov    $0x70,%ebx
    1af2:	0f 94 c2             	sete   %dl
    1af5:	83 ff 09             	cmp    $0x9,%edi
      name[1] = '0' + i;
    1af8:	88 45 c6             	mov    %al,-0x3a(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    1afb:	0f 9f c0             	setg   %al
    1afe:	09 c2                	or     %eax,%edx
    1b00:	88 55 c7             	mov    %dl,-0x39(%ebp)
      name[1] = '0' + i;
    1b03:	0f b6 45 c6          	movzbl -0x3a(%ebp),%eax
      fd = open(name, 0);
    1b07:	83 ec 08             	sub    $0x8,%esp
      name[0] = 'p' + pi;
    1b0a:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1b0d:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1b10:	6a 00                	push   $0x0
    1b12:	56                   	push   %esi
    1b13:	e8 5b 26 00 00       	call   4173 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1b18:	83 c4 10             	add    $0x10,%esp
    1b1b:	80 7d c7 00          	cmpb   $0x0,-0x39(%ebp)
    1b1f:	74 7f                	je     1ba0 <createdelete+0x110>
    1b21:	85 c0                	test   %eax,%eax
    1b23:	0f 88 27 01 00 00    	js     1c50 <createdelete+0x1c0>
        close(fd);
    1b29:	83 ec 0c             	sub    $0xc,%esp
    1b2c:	50                   	push   %eax
    1b2d:	e8 29 26 00 00       	call   415b <close>
    1b32:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    1b35:	83 c3 01             	add    $0x1,%ebx
    1b38:	80 fb 74             	cmp    $0x74,%bl
    1b3b:	75 c6                	jne    1b03 <createdelete+0x73>
  for(i = 0; i < N; i++){
    1b3d:	83 c7 01             	add    $0x1,%edi
    1b40:	83 ff 14             	cmp    $0x14,%edi
    1b43:	75 a3                	jne    1ae8 <createdelete+0x58>
    1b45:	bf 70 00 00 00       	mov    $0x70,%edi
    1b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[1] = '0' + i;
    1b50:	8d 47 c0             	lea    -0x40(%edi),%eax
    1b53:	bb 04 00 00 00       	mov    $0x4,%ebx
    1b58:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[0] = 'p' + i;
    1b5b:	89 f8                	mov    %edi,%eax
      unlink(name);
    1b5d:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    1b60:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1b63:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1b67:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    1b6a:	56                   	push   %esi
    1b6b:	e8 13 26 00 00       	call   4183 <unlink>
    for(pi = 0; pi < 4; pi++){
    1b70:	83 c4 10             	add    $0x10,%esp
    1b73:	83 eb 01             	sub    $0x1,%ebx
    1b76:	75 e3                	jne    1b5b <createdelete+0xcb>
  for(i = 0; i < N; i++){
    1b78:	83 c7 01             	add    $0x1,%edi
    1b7b:	89 f8                	mov    %edi,%eax
    1b7d:	3c 84                	cmp    $0x84,%al
    1b7f:	75 cf                	jne    1b50 <createdelete+0xc0>
  printf(1, "createdelete ok\n");
    1b81:	83 ec 08             	sub    $0x8,%esp
    1b84:	68 01 59 00 00       	push   $0x5901
    1b89:	6a 01                	push   $0x1
    1b8b:	e8 20 27 00 00       	call   42b0 <printf>
}
    1b90:	83 c4 10             	add    $0x10,%esp
    1b93:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b96:	5b                   	pop    %ebx
    1b97:	5e                   	pop    %esi
    1b98:	5f                   	pop    %edi
    1b99:	5d                   	pop    %ebp
    1b9a:	c3                   	ret
    1b9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ba0:	85 c0                	test   %eax,%eax
    1ba2:	78 91                	js     1b35 <createdelete+0xa5>
        printf(1, "oops createdelete %s did exist\n", name);
    1ba4:	50                   	push   %eax
    1ba5:	56                   	push   %esi
    1ba6:	68 44 4d 00 00       	push   $0x4d44
    1bab:	6a 01                	push   $0x1
    1bad:	e8 fe 26 00 00       	call   42b0 <printf>
        exit();
    1bb2:	e8 7c 25 00 00       	call   4133 <exit>
    1bb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1bbe:	00 
    1bbf:	90                   	nop
      name[0] = 'p' + pi;
    1bc0:	8d 46 70             	lea    0x70(%esi),%eax
      name[2] = '\0';
    1bc3:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1bc7:	8d 75 c8             	lea    -0x38(%ebp),%esi
      name[0] = 'p' + pi;
    1bca:	88 45 c8             	mov    %al,-0x38(%ebp)
      for(i = 0; i < N; i++){
    1bcd:	8d 76 00             	lea    0x0(%esi),%esi
        fd = open(name, O_CREATE | O_RDWR);
    1bd0:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    1bd3:	8d 43 30             	lea    0x30(%ebx),%eax
    1bd6:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1bd9:	68 02 02 00 00       	push   $0x202
    1bde:	56                   	push   %esi
    1bdf:	e8 8f 25 00 00       	call   4173 <open>
        if(fd < 0){
    1be4:	83 c4 10             	add    $0x10,%esp
    1be7:	85 c0                	test   %eax,%eax
    1be9:	0f 88 8a 00 00 00    	js     1c79 <createdelete+0x1e9>
        close(fd);
    1bef:	83 ec 0c             	sub    $0xc,%esp
    1bf2:	50                   	push   %eax
    1bf3:	e8 63 25 00 00       	call   415b <close>
        if(i > 0 && (i % 2 ) == 0){
    1bf8:	83 c4 10             	add    $0x10,%esp
    1bfb:	85 db                	test   %ebx,%ebx
    1bfd:	74 19                	je     1c18 <createdelete+0x188>
    1bff:	f6 c3 01             	test   $0x1,%bl
    1c02:	74 1b                	je     1c1f <createdelete+0x18f>
      for(i = 0; i < N; i++){
    1c04:	83 c3 01             	add    $0x1,%ebx
    1c07:	83 fb 14             	cmp    $0x14,%ebx
    1c0a:	75 c4                	jne    1bd0 <createdelete+0x140>
      exit();
    1c0c:	e8 22 25 00 00       	call   4133 <exit>
    1c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1c18:	bb 01 00 00 00       	mov    $0x1,%ebx
    1c1d:	eb b1                	jmp    1bd0 <createdelete+0x140>
          name[1] = '0' + (i / 2);
    1c1f:	89 d8                	mov    %ebx,%eax
          if(unlink(name) < 0){
    1c21:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    1c24:	d1 f8                	sar    $1,%eax
    1c26:	83 c0 30             	add    $0x30,%eax
    1c29:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1c2c:	56                   	push   %esi
    1c2d:	e8 51 25 00 00       	call   4183 <unlink>
    1c32:	83 c4 10             	add    $0x10,%esp
    1c35:	85 c0                	test   %eax,%eax
    1c37:	79 cb                	jns    1c04 <createdelete+0x174>
            printf(1, "unlink failed\n");
    1c39:	52                   	push   %edx
    1c3a:	52                   	push   %edx
    1c3b:	68 ef 54 00 00       	push   $0x54ef
    1c40:	6a 01                	push   $0x1
    1c42:	e8 69 26 00 00       	call   42b0 <printf>
            exit();
    1c47:	e8 e7 24 00 00       	call   4133 <exit>
    1c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "oops createdelete %s didn't exist\n", name);
    1c50:	83 ec 04             	sub    $0x4,%esp
    1c53:	56                   	push   %esi
    1c54:	68 20 4d 00 00       	push   $0x4d20
    1c59:	6a 01                	push   $0x1
    1c5b:	e8 50 26 00 00       	call   42b0 <printf>
        exit();
    1c60:	e8 ce 24 00 00       	call   4133 <exit>
      printf(1, "fork failed\n");
    1c65:	83 ec 08             	sub    $0x8,%esp
    1c68:	68 77 63 00 00       	push   $0x6377
    1c6d:	6a 01                	push   $0x1
    1c6f:	e8 3c 26 00 00       	call   42b0 <printf>
      exit();
    1c74:	e8 ba 24 00 00       	call   4133 <exit>
          printf(1, "create failed\n");
    1c79:	83 ec 08             	sub    $0x8,%esp
    1c7c:	68 3d 5b 00 00       	push   $0x5b3d
    1c81:	6a 01                	push   $0x1
    1c83:	e8 28 26 00 00       	call   42b0 <printf>
          exit();
    1c88:	e8 a6 24 00 00       	call   4133 <exit>
    1c8d:	8d 76 00             	lea    0x0(%esi),%esi

00001c90 <unlinkread>:
{
    1c90:	55                   	push   %ebp
    1c91:	89 e5                	mov    %esp,%ebp
    1c93:	56                   	push   %esi
    1c94:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1c95:	83 ec 08             	sub    $0x8,%esp
    1c98:	68 12 59 00 00       	push   $0x5912
    1c9d:	6a 01                	push   $0x1
    1c9f:	e8 0c 26 00 00       	call   42b0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1ca4:	5b                   	pop    %ebx
    1ca5:	5e                   	pop    %esi
    1ca6:	68 02 02 00 00       	push   $0x202
    1cab:	68 23 59 00 00       	push   $0x5923
    1cb0:	e8 be 24 00 00       	call   4173 <open>
  if(fd < 0){
    1cb5:	83 c4 10             	add    $0x10,%esp
    1cb8:	85 c0                	test   %eax,%eax
    1cba:	0f 88 e6 00 00 00    	js     1da6 <unlinkread+0x116>
  write(fd, "hello", 5);
    1cc0:	83 ec 04             	sub    $0x4,%esp
    1cc3:	89 c3                	mov    %eax,%ebx
    1cc5:	6a 05                	push   $0x5
    1cc7:	68 48 59 00 00       	push   $0x5948
    1ccc:	50                   	push   %eax
    1ccd:	e8 81 24 00 00       	call   4153 <write>
  close(fd);
    1cd2:	89 1c 24             	mov    %ebx,(%esp)
    1cd5:	e8 81 24 00 00       	call   415b <close>
  fd = open("unlinkread", O_RDWR);
    1cda:	58                   	pop    %eax
    1cdb:	5a                   	pop    %edx
    1cdc:	6a 02                	push   $0x2
    1cde:	68 23 59 00 00       	push   $0x5923
    1ce3:	e8 8b 24 00 00       	call   4173 <open>
  if(fd < 0){
    1ce8:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_RDWR);
    1ceb:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ced:	85 c0                	test   %eax,%eax
    1cef:	0f 88 10 01 00 00    	js     1e05 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
    1cf5:	83 ec 0c             	sub    $0xc,%esp
    1cf8:	68 23 59 00 00       	push   $0x5923
    1cfd:	e8 81 24 00 00       	call   4183 <unlink>
    1d02:	83 c4 10             	add    $0x10,%esp
    1d05:	85 c0                	test   %eax,%eax
    1d07:	0f 85 e5 00 00 00    	jne    1df2 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1d0d:	83 ec 08             	sub    $0x8,%esp
    1d10:	68 02 02 00 00       	push   $0x202
    1d15:	68 23 59 00 00       	push   $0x5923
    1d1a:	e8 54 24 00 00       	call   4173 <open>
  write(fd1, "yyy", 3);
    1d1f:	83 c4 0c             	add    $0xc,%esp
    1d22:	6a 03                	push   $0x3
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1d24:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1d26:	68 80 59 00 00       	push   $0x5980
    1d2b:	50                   	push   %eax
    1d2c:	e8 22 24 00 00       	call   4153 <write>
  close(fd1);
    1d31:	89 34 24             	mov    %esi,(%esp)
    1d34:	e8 22 24 00 00       	call   415b <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    1d39:	83 c4 0c             	add    $0xc,%esp
    1d3c:	68 00 20 00 00       	push   $0x2000
    1d41:	68 c0 95 00 00       	push   $0x95c0
    1d46:	53                   	push   %ebx
    1d47:	e8 ff 23 00 00       	call   414b <read>
    1d4c:	83 c4 10             	add    $0x10,%esp
    1d4f:	83 f8 05             	cmp    $0x5,%eax
    1d52:	0f 85 87 00 00 00    	jne    1ddf <unlinkread+0x14f>
  if(buf[0] != 'h'){
    1d58:	80 3d c0 95 00 00 68 	cmpb   $0x68,0x95c0
    1d5f:	75 6b                	jne    1dcc <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    1d61:	83 ec 04             	sub    $0x4,%esp
    1d64:	6a 0a                	push   $0xa
    1d66:	68 c0 95 00 00       	push   $0x95c0
    1d6b:	53                   	push   %ebx
    1d6c:	e8 e2 23 00 00       	call   4153 <write>
    1d71:	83 c4 10             	add    $0x10,%esp
    1d74:	83 f8 0a             	cmp    $0xa,%eax
    1d77:	75 40                	jne    1db9 <unlinkread+0x129>
  close(fd);
    1d79:	83 ec 0c             	sub    $0xc,%esp
    1d7c:	53                   	push   %ebx
    1d7d:	e8 d9 23 00 00       	call   415b <close>
  unlink("unlinkread");
    1d82:	c7 04 24 23 59 00 00 	movl   $0x5923,(%esp)
    1d89:	e8 f5 23 00 00       	call   4183 <unlink>
  printf(1, "unlinkread ok\n");
    1d8e:	58                   	pop    %eax
    1d8f:	5a                   	pop    %edx
    1d90:	68 cb 59 00 00       	push   $0x59cb
    1d95:	6a 01                	push   $0x1
    1d97:	e8 14 25 00 00       	call   42b0 <printf>
}
    1d9c:	83 c4 10             	add    $0x10,%esp
    1d9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1da2:	5b                   	pop    %ebx
    1da3:	5e                   	pop    %esi
    1da4:	5d                   	pop    %ebp
    1da5:	c3                   	ret
    printf(1, "create unlinkread failed\n");
    1da6:	51                   	push   %ecx
    1da7:	51                   	push   %ecx
    1da8:	68 2e 59 00 00       	push   $0x592e
    1dad:	6a 01                	push   $0x1
    1daf:	e8 fc 24 00 00       	call   42b0 <printf>
    exit();
    1db4:	e8 7a 23 00 00       	call   4133 <exit>
    printf(1, "unlinkread write failed\n");
    1db9:	51                   	push   %ecx
    1dba:	51                   	push   %ecx
    1dbb:	68 b2 59 00 00       	push   $0x59b2
    1dc0:	6a 01                	push   $0x1
    1dc2:	e8 e9 24 00 00       	call   42b0 <printf>
    exit();
    1dc7:	e8 67 23 00 00       	call   4133 <exit>
    printf(1, "unlinkread wrong data\n");
    1dcc:	53                   	push   %ebx
    1dcd:	53                   	push   %ebx
    1dce:	68 9b 59 00 00       	push   $0x599b
    1dd3:	6a 01                	push   $0x1
    1dd5:	e8 d6 24 00 00       	call   42b0 <printf>
    exit();
    1dda:	e8 54 23 00 00       	call   4133 <exit>
    printf(1, "unlinkread read failed");
    1ddf:	56                   	push   %esi
    1de0:	56                   	push   %esi
    1de1:	68 84 59 00 00       	push   $0x5984
    1de6:	6a 01                	push   $0x1
    1de8:	e8 c3 24 00 00       	call   42b0 <printf>
    exit();
    1ded:	e8 41 23 00 00       	call   4133 <exit>
    printf(1, "unlink unlinkread failed\n");
    1df2:	50                   	push   %eax
    1df3:	50                   	push   %eax
    1df4:	68 66 59 00 00       	push   $0x5966
    1df9:	6a 01                	push   $0x1
    1dfb:	e8 b0 24 00 00       	call   42b0 <printf>
    exit();
    1e00:	e8 2e 23 00 00       	call   4133 <exit>
    printf(1, "open unlinkread failed\n");
    1e05:	50                   	push   %eax
    1e06:	50                   	push   %eax
    1e07:	68 4e 59 00 00       	push   $0x594e
    1e0c:	6a 01                	push   $0x1
    1e0e:	e8 9d 24 00 00       	call   42b0 <printf>
    exit();
    1e13:	e8 1b 23 00 00       	call   4133 <exit>
    1e18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    1e1f:	00 

00001e20 <linktest>:
{
    1e20:	55                   	push   %ebp
    1e21:	89 e5                	mov    %esp,%ebp
    1e23:	53                   	push   %ebx
    1e24:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    1e27:	68 da 59 00 00       	push   $0x59da
    1e2c:	6a 01                	push   $0x1
    1e2e:	e8 7d 24 00 00       	call   42b0 <printf>
  unlink("lf1");
    1e33:	c7 04 24 e4 59 00 00 	movl   $0x59e4,(%esp)
    1e3a:	e8 44 23 00 00       	call   4183 <unlink>
  unlink("lf2");
    1e3f:	c7 04 24 e8 59 00 00 	movl   $0x59e8,(%esp)
    1e46:	e8 38 23 00 00       	call   4183 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    1e4b:	58                   	pop    %eax
    1e4c:	5a                   	pop    %edx
    1e4d:	68 02 02 00 00       	push   $0x202
    1e52:	68 e4 59 00 00       	push   $0x59e4
    1e57:	e8 17 23 00 00       	call   4173 <open>
  if(fd < 0){
    1e5c:	83 c4 10             	add    $0x10,%esp
    1e5f:	85 c0                	test   %eax,%eax
    1e61:	0f 88 1e 01 00 00    	js     1f85 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
    1e67:	83 ec 04             	sub    $0x4,%esp
    1e6a:	89 c3                	mov    %eax,%ebx
    1e6c:	6a 05                	push   $0x5
    1e6e:	68 48 59 00 00       	push   $0x5948
    1e73:	50                   	push   %eax
    1e74:	e8 da 22 00 00       	call   4153 <write>
    1e79:	83 c4 10             	add    $0x10,%esp
    1e7c:	83 f8 05             	cmp    $0x5,%eax
    1e7f:	0f 85 98 01 00 00    	jne    201d <linktest+0x1fd>
  close(fd);
    1e85:	83 ec 0c             	sub    $0xc,%esp
    1e88:	53                   	push   %ebx
    1e89:	e8 cd 22 00 00       	call   415b <close>
  if(link("lf1", "lf2") < 0){
    1e8e:	5b                   	pop    %ebx
    1e8f:	58                   	pop    %eax
    1e90:	68 e8 59 00 00       	push   $0x59e8
    1e95:	68 e4 59 00 00       	push   $0x59e4
    1e9a:	e8 f4 22 00 00       	call   4193 <link>
    1e9f:	83 c4 10             	add    $0x10,%esp
    1ea2:	85 c0                	test   %eax,%eax
    1ea4:	0f 88 60 01 00 00    	js     200a <linktest+0x1ea>
  unlink("lf1");
    1eaa:	83 ec 0c             	sub    $0xc,%esp
    1ead:	68 e4 59 00 00       	push   $0x59e4
    1eb2:	e8 cc 22 00 00       	call   4183 <unlink>
  if(open("lf1", 0) >= 0){
    1eb7:	58                   	pop    %eax
    1eb8:	5a                   	pop    %edx
    1eb9:	6a 00                	push   $0x0
    1ebb:	68 e4 59 00 00       	push   $0x59e4
    1ec0:	e8 ae 22 00 00       	call   4173 <open>
    1ec5:	83 c4 10             	add    $0x10,%esp
    1ec8:	85 c0                	test   %eax,%eax
    1eca:	0f 89 27 01 00 00    	jns    1ff7 <linktest+0x1d7>
  fd = open("lf2", 0);
    1ed0:	83 ec 08             	sub    $0x8,%esp
    1ed3:	6a 00                	push   $0x0
    1ed5:	68 e8 59 00 00       	push   $0x59e8
    1eda:	e8 94 22 00 00       	call   4173 <open>
  if(fd < 0){
    1edf:	83 c4 10             	add    $0x10,%esp
  fd = open("lf2", 0);
    1ee2:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ee4:	85 c0                	test   %eax,%eax
    1ee6:	0f 88 f8 00 00 00    	js     1fe4 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
    1eec:	83 ec 04             	sub    $0x4,%esp
    1eef:	68 00 20 00 00       	push   $0x2000
    1ef4:	68 c0 95 00 00       	push   $0x95c0
    1ef9:	50                   	push   %eax
    1efa:	e8 4c 22 00 00       	call   414b <read>
    1eff:	83 c4 10             	add    $0x10,%esp
    1f02:	83 f8 05             	cmp    $0x5,%eax
    1f05:	0f 85 c6 00 00 00    	jne    1fd1 <linktest+0x1b1>
  close(fd);
    1f0b:	83 ec 0c             	sub    $0xc,%esp
    1f0e:	53                   	push   %ebx
    1f0f:	e8 47 22 00 00       	call   415b <close>
  if(link("lf2", "lf2") >= 0){
    1f14:	58                   	pop    %eax
    1f15:	5a                   	pop    %edx
    1f16:	68 e8 59 00 00       	push   $0x59e8
    1f1b:	68 e8 59 00 00       	push   $0x59e8
    1f20:	e8 6e 22 00 00       	call   4193 <link>
    1f25:	83 c4 10             	add    $0x10,%esp
    1f28:	85 c0                	test   %eax,%eax
    1f2a:	0f 89 8e 00 00 00    	jns    1fbe <linktest+0x19e>
  unlink("lf2");
    1f30:	83 ec 0c             	sub    $0xc,%esp
    1f33:	68 e8 59 00 00       	push   $0x59e8
    1f38:	e8 46 22 00 00       	call   4183 <unlink>
  if(link("lf2", "lf1") >= 0){
    1f3d:	59                   	pop    %ecx
    1f3e:	5b                   	pop    %ebx
    1f3f:	68 e4 59 00 00       	push   $0x59e4
    1f44:	68 e8 59 00 00       	push   $0x59e8
    1f49:	e8 45 22 00 00       	call   4193 <link>
    1f4e:	83 c4 10             	add    $0x10,%esp
    1f51:	85 c0                	test   %eax,%eax
    1f53:	79 56                	jns    1fab <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    1f55:	83 ec 08             	sub    $0x8,%esp
    1f58:	68 e4 59 00 00       	push   $0x59e4
    1f5d:	68 ac 5c 00 00       	push   $0x5cac
    1f62:	e8 2c 22 00 00       	call   4193 <link>
    1f67:	83 c4 10             	add    $0x10,%esp
    1f6a:	85 c0                	test   %eax,%eax
    1f6c:	79 2a                	jns    1f98 <linktest+0x178>
  printf(1, "linktest ok\n");
    1f6e:	83 ec 08             	sub    $0x8,%esp
    1f71:	68 82 5a 00 00       	push   $0x5a82
    1f76:	6a 01                	push   $0x1
    1f78:	e8 33 23 00 00       	call   42b0 <printf>
}
    1f7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f80:	83 c4 10             	add    $0x10,%esp
    1f83:	c9                   	leave
    1f84:	c3                   	ret
    printf(1, "create lf1 failed\n");
    1f85:	50                   	push   %eax
    1f86:	50                   	push   %eax
    1f87:	68 ec 59 00 00       	push   $0x59ec
    1f8c:	6a 01                	push   $0x1
    1f8e:	e8 1d 23 00 00       	call   42b0 <printf>
    exit();
    1f93:	e8 9b 21 00 00       	call   4133 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1f98:	50                   	push   %eax
    1f99:	50                   	push   %eax
    1f9a:	68 66 5a 00 00       	push   $0x5a66
    1f9f:	6a 01                	push   $0x1
    1fa1:	e8 0a 23 00 00       	call   42b0 <printf>
    exit();
    1fa6:	e8 88 21 00 00       	call   4133 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    1fab:	52                   	push   %edx
    1fac:	52                   	push   %edx
    1fad:	68 8c 4d 00 00       	push   $0x4d8c
    1fb2:	6a 01                	push   $0x1
    1fb4:	e8 f7 22 00 00       	call   42b0 <printf>
    exit();
    1fb9:	e8 75 21 00 00       	call   4133 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1fbe:	50                   	push   %eax
    1fbf:	50                   	push   %eax
    1fc0:	68 48 5a 00 00       	push   $0x5a48
    1fc5:	6a 01                	push   $0x1
    1fc7:	e8 e4 22 00 00       	call   42b0 <printf>
    exit();
    1fcc:	e8 62 21 00 00       	call   4133 <exit>
    printf(1, "read lf2 failed\n");
    1fd1:	51                   	push   %ecx
    1fd2:	51                   	push   %ecx
    1fd3:	68 37 5a 00 00       	push   $0x5a37
    1fd8:	6a 01                	push   $0x1
    1fda:	e8 d1 22 00 00       	call   42b0 <printf>
    exit();
    1fdf:	e8 4f 21 00 00       	call   4133 <exit>
    printf(1, "open lf2 failed\n");
    1fe4:	53                   	push   %ebx
    1fe5:	53                   	push   %ebx
    1fe6:	68 26 5a 00 00       	push   $0x5a26
    1feb:	6a 01                	push   $0x1
    1fed:	e8 be 22 00 00       	call   42b0 <printf>
    exit();
    1ff2:	e8 3c 21 00 00       	call   4133 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1ff7:	50                   	push   %eax
    1ff8:	50                   	push   %eax
    1ff9:	68 64 4d 00 00       	push   $0x4d64
    1ffe:	6a 01                	push   $0x1
    2000:	e8 ab 22 00 00       	call   42b0 <printf>
    exit();
    2005:	e8 29 21 00 00       	call   4133 <exit>
    printf(1, "link lf1 lf2 failed\n");
    200a:	51                   	push   %ecx
    200b:	51                   	push   %ecx
    200c:	68 11 5a 00 00       	push   $0x5a11
    2011:	6a 01                	push   $0x1
    2013:	e8 98 22 00 00       	call   42b0 <printf>
    exit();
    2018:	e8 16 21 00 00       	call   4133 <exit>
    printf(1, "write lf1 failed\n");
    201d:	50                   	push   %eax
    201e:	50                   	push   %eax
    201f:	68 ff 59 00 00       	push   $0x59ff
    2024:	6a 01                	push   $0x1
    2026:	e8 85 22 00 00       	call   42b0 <printf>
    exit();
    202b:	e8 03 21 00 00       	call   4133 <exit>

00002030 <concreate>:
{
    2030:	55                   	push   %ebp
    2031:	89 e5                	mov    %esp,%ebp
    2033:	57                   	push   %edi
    2034:	56                   	push   %esi
  for(i = 0; i < 40; i++){
    2035:	31 f6                	xor    %esi,%esi
{
    2037:	53                   	push   %ebx
    2038:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    203b:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    203e:	68 8f 5a 00 00       	push   $0x5a8f
    2043:	6a 01                	push   $0x1
    2045:	e8 66 22 00 00       	call   42b0 <printf>
  file[0] = 'C';
    204a:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    204e:	83 c4 10             	add    $0x10,%esp
    2051:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
  for(i = 0; i < 40; i++){
    2055:	eb 4c                	jmp    20a3 <concreate+0x73>
    2057:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    205e:	00 
    205f:	90                   	nop
    2060:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    if(pid && (i % 3) == 1){
    2066:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    206b:	0f 83 8f 00 00 00    	jae    2100 <concreate+0xd0>
      fd = open(file, O_CREATE | O_RDWR);
    2071:	83 ec 08             	sub    $0x8,%esp
    2074:	68 02 02 00 00       	push   $0x202
    2079:	53                   	push   %ebx
    207a:	e8 f4 20 00 00       	call   4173 <open>
      if(fd < 0){
    207f:	83 c4 10             	add    $0x10,%esp
    2082:	85 c0                	test   %eax,%eax
    2084:	78 63                	js     20e9 <concreate+0xb9>
      close(fd);
    2086:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    2089:	83 c6 01             	add    $0x1,%esi
      close(fd);
    208c:	50                   	push   %eax
    208d:	e8 c9 20 00 00       	call   415b <close>
    2092:	83 c4 10             	add    $0x10,%esp
      wait();
    2095:	e8 a1 20 00 00       	call   413b <wait>
  for(i = 0; i < 40; i++){
    209a:	83 fe 28             	cmp    $0x28,%esi
    209d:	0f 84 7f 00 00 00    	je     2122 <concreate+0xf2>
    unlink(file);
    20a3:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    20a6:	8d 46 30             	lea    0x30(%esi),%eax
    20a9:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    20ac:	53                   	push   %ebx
    20ad:	e8 d1 20 00 00       	call   4183 <unlink>
    pid = fork();
    20b2:	e8 74 20 00 00       	call   412b <fork>
    if(pid && (i % 3) == 1){
    20b7:	83 c4 10             	add    $0x10,%esp
    20ba:	85 c0                	test   %eax,%eax
    20bc:	75 a2                	jne    2060 <concreate+0x30>
      link("C0", file);
    20be:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    } else if(pid == 0 && (i % 5) == 1){
    20c4:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    20ca:	0f 83 d0 00 00 00    	jae    21a0 <concreate+0x170>
      fd = open(file, O_CREATE | O_RDWR);
    20d0:	83 ec 08             	sub    $0x8,%esp
    20d3:	68 02 02 00 00       	push   $0x202
    20d8:	53                   	push   %ebx
    20d9:	e8 95 20 00 00       	call   4173 <open>
      if(fd < 0){
    20de:	83 c4 10             	add    $0x10,%esp
    20e1:	85 c0                	test   %eax,%eax
    20e3:	0f 89 ea 01 00 00    	jns    22d3 <concreate+0x2a3>
        printf(1, "concreate create %s failed\n", file);
    20e9:	83 ec 04             	sub    $0x4,%esp
    20ec:	53                   	push   %ebx
    20ed:	68 a2 5a 00 00       	push   $0x5aa2
    20f2:	6a 01                	push   $0x1
    20f4:	e8 b7 21 00 00       	call   42b0 <printf>
        exit();
    20f9:	e8 35 20 00 00       	call   4133 <exit>
    20fe:	66 90                	xchg   %ax,%ax
      link("C0", file);
    2100:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    2103:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    2106:	53                   	push   %ebx
    2107:	68 9f 5a 00 00       	push   $0x5a9f
    210c:	e8 82 20 00 00       	call   4193 <link>
    2111:	83 c4 10             	add    $0x10,%esp
      wait();
    2114:	e8 22 20 00 00       	call   413b <wait>
  for(i = 0; i < 40; i++){
    2119:	83 fe 28             	cmp    $0x28,%esi
    211c:	0f 85 81 ff ff ff    	jne    20a3 <concreate+0x73>
  memset(fa, 0, sizeof(fa));
    2122:	83 ec 04             	sub    $0x4,%esp
    2125:	8d 45 c0             	lea    -0x40(%ebp),%eax
    2128:	6a 28                	push   $0x28
    212a:	6a 00                	push   $0x0
    212c:	50                   	push   %eax
    212d:	e8 7e 1e 00 00       	call   3fb0 <memset>
  fd = open(".", 0);
    2132:	5e                   	pop    %esi
    2133:	5f                   	pop    %edi
    2134:	6a 00                	push   $0x0
    2136:	68 ac 5c 00 00       	push   $0x5cac
    213b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    213e:	e8 30 20 00 00       	call   4173 <open>
  while(read(fd, &de, sizeof(de)) > 0){
    2143:	83 c4 10             	add    $0x10,%esp
  n = 0;
    2146:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  fd = open(".", 0);
    214d:	89 c6                	mov    %eax,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    214f:	90                   	nop
    2150:	83 ec 04             	sub    $0x4,%esp
    2153:	6a 10                	push   $0x10
    2155:	57                   	push   %edi
    2156:	56                   	push   %esi
    2157:	e8 ef 1f 00 00       	call   414b <read>
    215c:	83 c4 10             	add    $0x10,%esp
    215f:	85 c0                	test   %eax,%eax
    2161:	7e 5d                	jle    21c0 <concreate+0x190>
    if(de.inum == 0)
    2163:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    2168:	74 e6                	je     2150 <concreate+0x120>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    216a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    216e:	75 e0                	jne    2150 <concreate+0x120>
    2170:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    2174:	75 da                	jne    2150 <concreate+0x120>
      i = de.name[1] - '0';
    2176:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    217a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    217d:	83 f8 27             	cmp    $0x27,%eax
    2180:	0f 87 5e 01 00 00    	ja     22e4 <concreate+0x2b4>
      if(fa[i]){
    2186:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    218b:	0f 85 7e 01 00 00    	jne    230f <concreate+0x2df>
      n++;
    2191:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
      fa[i] = 1;
    2195:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    219a:	eb b4                	jmp    2150 <concreate+0x120>
    219c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      link("C0", file);
    21a0:	83 ec 08             	sub    $0x8,%esp
    21a3:	53                   	push   %ebx
    21a4:	68 9f 5a 00 00       	push   $0x5a9f
    21a9:	e8 e5 1f 00 00       	call   4193 <link>
    21ae:	83 c4 10             	add    $0x10,%esp
      exit();
    21b1:	e8 7d 1f 00 00       	call   4133 <exit>
    21b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    21bd:	00 
    21be:	66 90                	xchg   %ax,%ax
  close(fd);
    21c0:	83 ec 0c             	sub    $0xc,%esp
    21c3:	56                   	push   %esi
    21c4:	e8 92 1f 00 00       	call   415b <close>
  if(n != 40){
    21c9:	83 c4 10             	add    $0x10,%esp
    21cc:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    21d0:	0f 85 26 01 00 00    	jne    22fc <concreate+0x2cc>
  for(i = 0; i < 40; i++){
    21d6:	31 f6                	xor    %esi,%esi
    21d8:	eb 48                	jmp    2222 <concreate+0x1f2>
    21da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    21e0:	83 f8 01             	cmp    $0x1,%eax
    21e3:	75 04                	jne    21e9 <concreate+0x1b9>
    21e5:	85 ff                	test   %edi,%edi
    21e7:	75 68                	jne    2251 <concreate+0x221>
      unlink(file);
    21e9:	83 ec 0c             	sub    $0xc,%esp
    21ec:	53                   	push   %ebx
    21ed:	e8 91 1f 00 00       	call   4183 <unlink>
      unlink(file);
    21f2:	89 1c 24             	mov    %ebx,(%esp)
    21f5:	e8 89 1f 00 00       	call   4183 <unlink>
      unlink(file);
    21fa:	89 1c 24             	mov    %ebx,(%esp)
    21fd:	e8 81 1f 00 00       	call   4183 <unlink>
      unlink(file);
    2202:	89 1c 24             	mov    %ebx,(%esp)
    2205:	e8 79 1f 00 00       	call   4183 <unlink>
    220a:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    220d:	85 ff                	test   %edi,%edi
    220f:	74 a0                	je     21b1 <concreate+0x181>
      wait();
    2211:	e8 25 1f 00 00       	call   413b <wait>
  for(i = 0; i < 40; i++){
    2216:	83 c6 01             	add    $0x1,%esi
    2219:	83 fe 28             	cmp    $0x28,%esi
    221c:	0f 84 86 00 00 00    	je     22a8 <concreate+0x278>
    file[1] = '0' + i;
    2222:	8d 46 30             	lea    0x30(%esi),%eax
    2225:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    2228:	e8 fe 1e 00 00       	call   412b <fork>
    222d:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    222f:	85 c0                	test   %eax,%eax
    2231:	0f 88 88 00 00 00    	js     22bf <concreate+0x28f>
    if(((i % 3) == 0 && pid == 0) ||
    2237:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    223c:	f7 e6                	mul    %esi
    223e:	89 d0                	mov    %edx,%eax
    2240:	83 e2 fe             	and    $0xfffffffe,%edx
    2243:	d1 e8                	shr    $1,%eax
    2245:	01 c2                	add    %eax,%edx
    2247:	89 f0                	mov    %esi,%eax
    2249:	29 d0                	sub    %edx,%eax
    224b:	89 c1                	mov    %eax,%ecx
    224d:	09 f9                	or     %edi,%ecx
    224f:	75 8f                	jne    21e0 <concreate+0x1b0>
      close(open(file, 0));
    2251:	83 ec 08             	sub    $0x8,%esp
    2254:	6a 00                	push   $0x0
    2256:	53                   	push   %ebx
    2257:	e8 17 1f 00 00       	call   4173 <open>
    225c:	89 04 24             	mov    %eax,(%esp)
    225f:	e8 f7 1e 00 00       	call   415b <close>
      close(open(file, 0));
    2264:	58                   	pop    %eax
    2265:	5a                   	pop    %edx
    2266:	6a 00                	push   $0x0
    2268:	53                   	push   %ebx
    2269:	e8 05 1f 00 00       	call   4173 <open>
    226e:	89 04 24             	mov    %eax,(%esp)
    2271:	e8 e5 1e 00 00       	call   415b <close>
      close(open(file, 0));
    2276:	59                   	pop    %ecx
    2277:	58                   	pop    %eax
    2278:	6a 00                	push   $0x0
    227a:	53                   	push   %ebx
    227b:	e8 f3 1e 00 00       	call   4173 <open>
    2280:	89 04 24             	mov    %eax,(%esp)
    2283:	e8 d3 1e 00 00       	call   415b <close>
      close(open(file, 0));
    2288:	58                   	pop    %eax
    2289:	5a                   	pop    %edx
    228a:	6a 00                	push   $0x0
    228c:	53                   	push   %ebx
    228d:	e8 e1 1e 00 00       	call   4173 <open>
    2292:	89 04 24             	mov    %eax,(%esp)
    2295:	e8 c1 1e 00 00       	call   415b <close>
    229a:	83 c4 10             	add    $0x10,%esp
    229d:	e9 6b ff ff ff       	jmp    220d <concreate+0x1dd>
    22a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  printf(1, "concreate ok\n");
    22a8:	83 ec 08             	sub    $0x8,%esp
    22ab:	68 f4 5a 00 00       	push   $0x5af4
    22b0:	6a 01                	push   $0x1
    22b2:	e8 f9 1f 00 00       	call   42b0 <printf>
}
    22b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    22ba:	5b                   	pop    %ebx
    22bb:	5e                   	pop    %esi
    22bc:	5f                   	pop    %edi
    22bd:	5d                   	pop    %ebp
    22be:	c3                   	ret
      printf(1, "fork failed\n");
    22bf:	83 ec 08             	sub    $0x8,%esp
    22c2:	68 77 63 00 00       	push   $0x6377
    22c7:	6a 01                	push   $0x1
    22c9:	e8 e2 1f 00 00       	call   42b0 <printf>
      exit();
    22ce:	e8 60 1e 00 00       	call   4133 <exit>
      close(fd);
    22d3:	83 ec 0c             	sub    $0xc,%esp
    22d6:	50                   	push   %eax
    22d7:	e8 7f 1e 00 00       	call   415b <close>
    22dc:	83 c4 10             	add    $0x10,%esp
    22df:	e9 cd fe ff ff       	jmp    21b1 <concreate+0x181>
        printf(1, "concreate weird file %s\n", de.name);
    22e4:	83 ec 04             	sub    $0x4,%esp
    22e7:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    22ea:	50                   	push   %eax
    22eb:	68 be 5a 00 00       	push   $0x5abe
    22f0:	6a 01                	push   $0x1
    22f2:	e8 b9 1f 00 00       	call   42b0 <printf>
        exit();
    22f7:	e8 37 1e 00 00       	call   4133 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    22fc:	51                   	push   %ecx
    22fd:	51                   	push   %ecx
    22fe:	68 b0 4d 00 00       	push   $0x4db0
    2303:	6a 01                	push   $0x1
    2305:	e8 a6 1f 00 00       	call   42b0 <printf>
    exit();
    230a:	e8 24 1e 00 00       	call   4133 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    230f:	83 ec 04             	sub    $0x4,%esp
    2312:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    2315:	50                   	push   %eax
    2316:	68 d7 5a 00 00       	push   $0x5ad7
    231b:	6a 01                	push   $0x1
    231d:	e8 8e 1f 00 00       	call   42b0 <printf>
        exit();
    2322:	e8 0c 1e 00 00       	call   4133 <exit>
    2327:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    232e:	00 
    232f:	90                   	nop

00002330 <linkunlink>:
{
    2330:	55                   	push   %ebp
    2331:	89 e5                	mov    %esp,%ebp
    2333:	57                   	push   %edi
    2334:	56                   	push   %esi
    2335:	53                   	push   %ebx
    2336:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    2339:	68 02 5b 00 00       	push   $0x5b02
    233e:	6a 01                	push   $0x1
    2340:	e8 6b 1f 00 00       	call   42b0 <printf>
  unlink("x");
    2345:	c7 04 24 8f 5d 00 00 	movl   $0x5d8f,(%esp)
    234c:	e8 32 1e 00 00       	call   4183 <unlink>
  pid = fork();
    2351:	e8 d5 1d 00 00       	call   412b <fork>
  if(pid < 0){
    2356:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    2359:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    235c:	85 c0                	test   %eax,%eax
    235e:	0f 88 b6 00 00 00    	js     241a <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    2364:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    2368:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    236d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    2372:	19 ff                	sbb    %edi,%edi
    2374:	83 e7 60             	and    $0x60,%edi
    2377:	83 c7 01             	add    $0x1,%edi
    237a:	eb 1e                	jmp    239a <linkunlink+0x6a>
    237c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    2380:	83 f8 01             	cmp    $0x1,%eax
    2383:	74 7b                	je     2400 <linkunlink+0xd0>
      unlink("x");
    2385:	83 ec 0c             	sub    $0xc,%esp
    2388:	68 8f 5d 00 00       	push   $0x5d8f
    238d:	e8 f1 1d 00 00       	call   4183 <unlink>
    2392:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    2395:	83 eb 01             	sub    $0x1,%ebx
    2398:	74 41                	je     23db <linkunlink+0xab>
    x = x * 1103515245 + 12345;
    239a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    23a0:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    23a6:	89 f8                	mov    %edi,%eax
    23a8:	f7 e6                	mul    %esi
    23aa:	89 d0                	mov    %edx,%eax
    23ac:	83 e2 fe             	and    $0xfffffffe,%edx
    23af:	d1 e8                	shr    $1,%eax
    23b1:	01 c2                	add    %eax,%edx
    23b3:	89 f8                	mov    %edi,%eax
    23b5:	29 d0                	sub    %edx,%eax
    23b7:	75 c7                	jne    2380 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    23b9:	83 ec 08             	sub    $0x8,%esp
    23bc:	68 02 02 00 00       	push   $0x202
    23c1:	68 8f 5d 00 00       	push   $0x5d8f
    23c6:	e8 a8 1d 00 00       	call   4173 <open>
    23cb:	89 04 24             	mov    %eax,(%esp)
    23ce:	e8 88 1d 00 00       	call   415b <close>
    23d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    23d6:	83 eb 01             	sub    $0x1,%ebx
    23d9:	75 bf                	jne    239a <linkunlink+0x6a>
  if(pid)
    23db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    23de:	85 c0                	test   %eax,%eax
    23e0:	74 4b                	je     242d <linkunlink+0xfd>
    wait();
    23e2:	e8 54 1d 00 00       	call   413b <wait>
  printf(1, "linkunlink ok\n");
    23e7:	83 ec 08             	sub    $0x8,%esp
    23ea:	68 17 5b 00 00       	push   $0x5b17
    23ef:	6a 01                	push   $0x1
    23f1:	e8 ba 1e 00 00       	call   42b0 <printf>
}
    23f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    23f9:	5b                   	pop    %ebx
    23fa:	5e                   	pop    %esi
    23fb:	5f                   	pop    %edi
    23fc:	5d                   	pop    %ebp
    23fd:	c3                   	ret
    23fe:	66 90                	xchg   %ax,%ax
      link("cat", "x");
    2400:	83 ec 08             	sub    $0x8,%esp
    2403:	68 8f 5d 00 00       	push   $0x5d8f
    2408:	68 13 5b 00 00       	push   $0x5b13
    240d:	e8 81 1d 00 00       	call   4193 <link>
    2412:	83 c4 10             	add    $0x10,%esp
    2415:	e9 7b ff ff ff       	jmp    2395 <linkunlink+0x65>
    printf(1, "fork failed\n");
    241a:	52                   	push   %edx
    241b:	52                   	push   %edx
    241c:	68 77 63 00 00       	push   $0x6377
    2421:	6a 01                	push   $0x1
    2423:	e8 88 1e 00 00       	call   42b0 <printf>
    exit();
    2428:	e8 06 1d 00 00       	call   4133 <exit>
    exit();
    242d:	e8 01 1d 00 00       	call   4133 <exit>
    2432:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    2439:	00 
    243a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002440 <bigdir>:
{
    2440:	55                   	push   %ebp
    2441:	89 e5                	mov    %esp,%ebp
    2443:	57                   	push   %edi
    2444:	56                   	push   %esi
    2445:	53                   	push   %ebx
    2446:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    2449:	68 26 5b 00 00       	push   $0x5b26
    244e:	6a 01                	push   $0x1
    2450:	e8 5b 1e 00 00       	call   42b0 <printf>
  unlink("bd");
    2455:	c7 04 24 33 5b 00 00 	movl   $0x5b33,(%esp)
    245c:	e8 22 1d 00 00       	call   4183 <unlink>
  fd = open("bd", O_CREATE);
    2461:	5a                   	pop    %edx
    2462:	59                   	pop    %ecx
    2463:	68 00 02 00 00       	push   $0x200
    2468:	68 33 5b 00 00       	push   $0x5b33
    246d:	e8 01 1d 00 00       	call   4173 <open>
  if(fd < 0){
    2472:	83 c4 10             	add    $0x10,%esp
    2475:	85 c0                	test   %eax,%eax
    2477:	0f 88 de 00 00 00    	js     255b <bigdir+0x11b>
  close(fd);
    247d:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    2480:	31 f6                	xor    %esi,%esi
    2482:	8d 7d de             	lea    -0x22(%ebp),%edi
  close(fd);
    2485:	50                   	push   %eax
    2486:	e8 d0 1c 00 00       	call   415b <close>
    248b:	83 c4 10             	add    $0x10,%esp
    248e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    2490:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    2492:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    2495:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    2499:	c1 f8 06             	sar    $0x6,%eax
    name[3] = '\0';
    249c:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    24a0:	83 c0 30             	add    $0x30,%eax
    24a3:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    24a6:	89 f0                	mov    %esi,%eax
    24a8:	83 e0 3f             	and    $0x3f,%eax
    24ab:	83 c0 30             	add    $0x30,%eax
    24ae:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    24b1:	57                   	push   %edi
    24b2:	68 33 5b 00 00       	push   $0x5b33
    24b7:	e8 d7 1c 00 00       	call   4193 <link>
    24bc:	83 c4 10             	add    $0x10,%esp
    24bf:	89 c3                	mov    %eax,%ebx
    24c1:	85 c0                	test   %eax,%eax
    24c3:	75 6e                	jne    2533 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    24c5:	83 c6 01             	add    $0x1,%esi
    24c8:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    24ce:	75 c0                	jne    2490 <bigdir+0x50>
  unlink("bd");
    24d0:	83 ec 0c             	sub    $0xc,%esp
    24d3:	68 33 5b 00 00       	push   $0x5b33
    24d8:	e8 a6 1c 00 00       	call   4183 <unlink>
    24dd:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + (i / 64);
    24e0:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    24e2:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    24e5:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    24e9:	c1 f8 06             	sar    $0x6,%eax
    name[3] = '\0';
    24ec:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    24f0:	83 c0 30             	add    $0x30,%eax
    24f3:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    24f6:	89 d8                	mov    %ebx,%eax
    24f8:	83 e0 3f             	and    $0x3f,%eax
    24fb:	83 c0 30             	add    $0x30,%eax
    24fe:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    2501:	57                   	push   %edi
    2502:	e8 7c 1c 00 00       	call   4183 <unlink>
    2507:	83 c4 10             	add    $0x10,%esp
    250a:	85 c0                	test   %eax,%eax
    250c:	75 39                	jne    2547 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    250e:	83 c3 01             	add    $0x1,%ebx
    2511:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    2517:	75 c7                	jne    24e0 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    2519:	83 ec 08             	sub    $0x8,%esp
    251c:	68 75 5b 00 00       	push   $0x5b75
    2521:	6a 01                	push   $0x1
    2523:	e8 88 1d 00 00       	call   42b0 <printf>
    2528:	83 c4 10             	add    $0x10,%esp
}
    252b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    252e:	5b                   	pop    %ebx
    252f:	5e                   	pop    %esi
    2530:	5f                   	pop    %edi
    2531:	5d                   	pop    %ebp
    2532:	c3                   	ret
      printf(1, "bigdir link failed\n");
    2533:	83 ec 08             	sub    $0x8,%esp
    2536:	68 4c 5b 00 00       	push   $0x5b4c
    253b:	6a 01                	push   $0x1
    253d:	e8 6e 1d 00 00       	call   42b0 <printf>
      exit();
    2542:	e8 ec 1b 00 00       	call   4133 <exit>
      printf(1, "bigdir unlink failed");
    2547:	83 ec 08             	sub    $0x8,%esp
    254a:	68 60 5b 00 00       	push   $0x5b60
    254f:	6a 01                	push   $0x1
    2551:	e8 5a 1d 00 00       	call   42b0 <printf>
      exit();
    2556:	e8 d8 1b 00 00       	call   4133 <exit>
    printf(1, "bigdir create failed\n");
    255b:	50                   	push   %eax
    255c:	50                   	push   %eax
    255d:	68 36 5b 00 00       	push   $0x5b36
    2562:	6a 01                	push   $0x1
    2564:	e8 47 1d 00 00       	call   42b0 <printf>
    exit();
    2569:	e8 c5 1b 00 00       	call   4133 <exit>
    256e:	66 90                	xchg   %ax,%ax

00002570 <subdir>:
{
    2570:	55                   	push   %ebp
    2571:	89 e5                	mov    %esp,%ebp
    2573:	53                   	push   %ebx
    2574:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    2577:	68 80 5b 00 00       	push   $0x5b80
    257c:	6a 01                	push   $0x1
    257e:	e8 2d 1d 00 00       	call   42b0 <printf>
  unlink("ff");
    2583:	c7 04 24 09 5c 00 00 	movl   $0x5c09,(%esp)
    258a:	e8 f4 1b 00 00       	call   4183 <unlink>
  if(mkdir("dd") != 0){
    258f:	c7 04 24 a6 5c 00 00 	movl   $0x5ca6,(%esp)
    2596:	e8 00 1c 00 00       	call   419b <mkdir>
    259b:	83 c4 10             	add    $0x10,%esp
    259e:	85 c0                	test   %eax,%eax
    25a0:	0f 85 b3 05 00 00    	jne    2b59 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    25a6:	83 ec 08             	sub    $0x8,%esp
    25a9:	68 02 02 00 00       	push   $0x202
    25ae:	68 df 5b 00 00       	push   $0x5bdf
    25b3:	e8 bb 1b 00 00       	call   4173 <open>
  if(fd < 0){
    25b8:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/ff", O_CREATE | O_RDWR);
    25bb:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    25bd:	85 c0                	test   %eax,%eax
    25bf:	0f 88 81 05 00 00    	js     2b46 <subdir+0x5d6>
  write(fd, "ff", 2);
    25c5:	83 ec 04             	sub    $0x4,%esp
    25c8:	6a 02                	push   $0x2
    25ca:	68 09 5c 00 00       	push   $0x5c09
    25cf:	50                   	push   %eax
    25d0:	e8 7e 1b 00 00       	call   4153 <write>
  close(fd);
    25d5:	89 1c 24             	mov    %ebx,(%esp)
    25d8:	e8 7e 1b 00 00       	call   415b <close>
  if(unlink("dd") >= 0){
    25dd:	c7 04 24 a6 5c 00 00 	movl   $0x5ca6,(%esp)
    25e4:	e8 9a 1b 00 00       	call   4183 <unlink>
    25e9:	83 c4 10             	add    $0x10,%esp
    25ec:	85 c0                	test   %eax,%eax
    25ee:	0f 89 3f 05 00 00    	jns    2b33 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    25f4:	83 ec 0c             	sub    $0xc,%esp
    25f7:	68 ba 5b 00 00       	push   $0x5bba
    25fc:	e8 9a 1b 00 00       	call   419b <mkdir>
    2601:	83 c4 10             	add    $0x10,%esp
    2604:	85 c0                	test   %eax,%eax
    2606:	0f 85 14 05 00 00    	jne    2b20 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    260c:	83 ec 08             	sub    $0x8,%esp
    260f:	68 02 02 00 00       	push   $0x202
    2614:	68 dc 5b 00 00       	push   $0x5bdc
    2619:	e8 55 1b 00 00       	call   4173 <open>
  if(fd < 0){
    261e:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2621:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2623:	85 c0                	test   %eax,%eax
    2625:	0f 88 24 04 00 00    	js     2a4f <subdir+0x4df>
  write(fd, "FF", 2);
    262b:	83 ec 04             	sub    $0x4,%esp
    262e:	6a 02                	push   $0x2
    2630:	68 fd 5b 00 00       	push   $0x5bfd
    2635:	50                   	push   %eax
    2636:	e8 18 1b 00 00       	call   4153 <write>
  close(fd);
    263b:	89 1c 24             	mov    %ebx,(%esp)
    263e:	e8 18 1b 00 00       	call   415b <close>
  fd = open("dd/dd/../ff", 0);
    2643:	58                   	pop    %eax
    2644:	5a                   	pop    %edx
    2645:	6a 00                	push   $0x0
    2647:	68 00 5c 00 00       	push   $0x5c00
    264c:	e8 22 1b 00 00       	call   4173 <open>
  if(fd < 0){
    2651:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/../ff", 0);
    2654:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2656:	85 c0                	test   %eax,%eax
    2658:	0f 88 de 03 00 00    	js     2a3c <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
    265e:	83 ec 04             	sub    $0x4,%esp
    2661:	68 00 20 00 00       	push   $0x2000
    2666:	68 c0 95 00 00       	push   $0x95c0
    266b:	50                   	push   %eax
    266c:	e8 da 1a 00 00       	call   414b <read>
  if(cc != 2 || buf[0] != 'f'){
    2671:	83 c4 10             	add    $0x10,%esp
    2674:	83 f8 02             	cmp    $0x2,%eax
    2677:	0f 85 3a 03 00 00    	jne    29b7 <subdir+0x447>
    267d:	80 3d c0 95 00 00 66 	cmpb   $0x66,0x95c0
    2684:	0f 85 2d 03 00 00    	jne    29b7 <subdir+0x447>
  close(fd);
    268a:	83 ec 0c             	sub    $0xc,%esp
    268d:	53                   	push   %ebx
    268e:	e8 c8 1a 00 00       	call   415b <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2693:	59                   	pop    %ecx
    2694:	5b                   	pop    %ebx
    2695:	68 40 5c 00 00       	push   $0x5c40
    269a:	68 dc 5b 00 00       	push   $0x5bdc
    269f:	e8 ef 1a 00 00       	call   4193 <link>
    26a4:	83 c4 10             	add    $0x10,%esp
    26a7:	85 c0                	test   %eax,%eax
    26a9:	0f 85 c6 03 00 00    	jne    2a75 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    26af:	83 ec 0c             	sub    $0xc,%esp
    26b2:	68 dc 5b 00 00       	push   $0x5bdc
    26b7:	e8 c7 1a 00 00       	call   4183 <unlink>
    26bc:	83 c4 10             	add    $0x10,%esp
    26bf:	85 c0                	test   %eax,%eax
    26c1:	0f 85 16 03 00 00    	jne    29dd <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    26c7:	83 ec 08             	sub    $0x8,%esp
    26ca:	6a 00                	push   $0x0
    26cc:	68 dc 5b 00 00       	push   $0x5bdc
    26d1:	e8 9d 1a 00 00       	call   4173 <open>
    26d6:	83 c4 10             	add    $0x10,%esp
    26d9:	85 c0                	test   %eax,%eax
    26db:	0f 89 2c 04 00 00    	jns    2b0d <subdir+0x59d>
  if(chdir("dd") != 0){
    26e1:	83 ec 0c             	sub    $0xc,%esp
    26e4:	68 a6 5c 00 00       	push   $0x5ca6
    26e9:	e8 b5 1a 00 00       	call   41a3 <chdir>
    26ee:	83 c4 10             	add    $0x10,%esp
    26f1:	85 c0                	test   %eax,%eax
    26f3:	0f 85 01 04 00 00    	jne    2afa <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    26f9:	83 ec 0c             	sub    $0xc,%esp
    26fc:	68 74 5c 00 00       	push   $0x5c74
    2701:	e8 9d 1a 00 00       	call   41a3 <chdir>
    2706:	83 c4 10             	add    $0x10,%esp
    2709:	85 c0                	test   %eax,%eax
    270b:	0f 85 b9 02 00 00    	jne    29ca <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    2711:	83 ec 0c             	sub    $0xc,%esp
    2714:	68 9a 5c 00 00       	push   $0x5c9a
    2719:	e8 85 1a 00 00       	call   41a3 <chdir>
    271e:	83 c4 10             	add    $0x10,%esp
    2721:	85 c0                	test   %eax,%eax
    2723:	0f 85 a1 02 00 00    	jne    29ca <subdir+0x45a>
  if(chdir("./..") != 0){
    2729:	83 ec 0c             	sub    $0xc,%esp
    272c:	68 a9 5c 00 00       	push   $0x5ca9
    2731:	e8 6d 1a 00 00       	call   41a3 <chdir>
    2736:	83 c4 10             	add    $0x10,%esp
    2739:	85 c0                	test   %eax,%eax
    273b:	0f 85 21 03 00 00    	jne    2a62 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    2741:	83 ec 08             	sub    $0x8,%esp
    2744:	6a 00                	push   $0x0
    2746:	68 40 5c 00 00       	push   $0x5c40
    274b:	e8 23 1a 00 00       	call   4173 <open>
  if(fd < 0){
    2750:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ffff", 0);
    2753:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    2755:	85 c0                	test   %eax,%eax
    2757:	0f 88 e0 04 00 00    	js     2c3d <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
    275d:	83 ec 04             	sub    $0x4,%esp
    2760:	68 00 20 00 00       	push   $0x2000
    2765:	68 c0 95 00 00       	push   $0x95c0
    276a:	50                   	push   %eax
    276b:	e8 db 19 00 00       	call   414b <read>
    2770:	83 c4 10             	add    $0x10,%esp
    2773:	83 f8 02             	cmp    $0x2,%eax
    2776:	0f 85 ae 04 00 00    	jne    2c2a <subdir+0x6ba>
  close(fd);
    277c:	83 ec 0c             	sub    $0xc,%esp
    277f:	53                   	push   %ebx
    2780:	e8 d6 19 00 00       	call   415b <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2785:	58                   	pop    %eax
    2786:	5a                   	pop    %edx
    2787:	6a 00                	push   $0x0
    2789:	68 dc 5b 00 00       	push   $0x5bdc
    278e:	e8 e0 19 00 00       	call   4173 <open>
    2793:	83 c4 10             	add    $0x10,%esp
    2796:	85 c0                	test   %eax,%eax
    2798:	0f 89 65 02 00 00    	jns    2a03 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    279e:	83 ec 08             	sub    $0x8,%esp
    27a1:	68 02 02 00 00       	push   $0x202
    27a6:	68 f4 5c 00 00       	push   $0x5cf4
    27ab:	e8 c3 19 00 00       	call   4173 <open>
    27b0:	83 c4 10             	add    $0x10,%esp
    27b3:	85 c0                	test   %eax,%eax
    27b5:	0f 89 35 02 00 00    	jns    29f0 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    27bb:	83 ec 08             	sub    $0x8,%esp
    27be:	68 02 02 00 00       	push   $0x202
    27c3:	68 19 5d 00 00       	push   $0x5d19
    27c8:	e8 a6 19 00 00       	call   4173 <open>
    27cd:	83 c4 10             	add    $0x10,%esp
    27d0:	85 c0                	test   %eax,%eax
    27d2:	0f 89 0f 03 00 00    	jns    2ae7 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    27d8:	83 ec 08             	sub    $0x8,%esp
    27db:	68 00 02 00 00       	push   $0x200
    27e0:	68 a6 5c 00 00       	push   $0x5ca6
    27e5:	e8 89 19 00 00       	call   4173 <open>
    27ea:	83 c4 10             	add    $0x10,%esp
    27ed:	85 c0                	test   %eax,%eax
    27ef:	0f 89 df 02 00 00    	jns    2ad4 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    27f5:	83 ec 08             	sub    $0x8,%esp
    27f8:	6a 02                	push   $0x2
    27fa:	68 a6 5c 00 00       	push   $0x5ca6
    27ff:	e8 6f 19 00 00       	call   4173 <open>
    2804:	83 c4 10             	add    $0x10,%esp
    2807:	85 c0                	test   %eax,%eax
    2809:	0f 89 b2 02 00 00    	jns    2ac1 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    280f:	83 ec 08             	sub    $0x8,%esp
    2812:	6a 01                	push   $0x1
    2814:	68 a6 5c 00 00       	push   $0x5ca6
    2819:	e8 55 19 00 00       	call   4173 <open>
    281e:	83 c4 10             	add    $0x10,%esp
    2821:	85 c0                	test   %eax,%eax
    2823:	0f 89 85 02 00 00    	jns    2aae <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2829:	83 ec 08             	sub    $0x8,%esp
    282c:	68 88 5d 00 00       	push   $0x5d88
    2831:	68 f4 5c 00 00       	push   $0x5cf4
    2836:	e8 58 19 00 00       	call   4193 <link>
    283b:	83 c4 10             	add    $0x10,%esp
    283e:	85 c0                	test   %eax,%eax
    2840:	0f 84 55 02 00 00    	je     2a9b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2846:	83 ec 08             	sub    $0x8,%esp
    2849:	68 88 5d 00 00       	push   $0x5d88
    284e:	68 19 5d 00 00       	push   $0x5d19
    2853:	e8 3b 19 00 00       	call   4193 <link>
    2858:	83 c4 10             	add    $0x10,%esp
    285b:	85 c0                	test   %eax,%eax
    285d:	0f 84 25 02 00 00    	je     2a88 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2863:	83 ec 08             	sub    $0x8,%esp
    2866:	68 40 5c 00 00       	push   $0x5c40
    286b:	68 df 5b 00 00       	push   $0x5bdf
    2870:	e8 1e 19 00 00       	call   4193 <link>
    2875:	83 c4 10             	add    $0x10,%esp
    2878:	85 c0                	test   %eax,%eax
    287a:	0f 84 a9 01 00 00    	je     2a29 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2880:	83 ec 0c             	sub    $0xc,%esp
    2883:	68 f4 5c 00 00       	push   $0x5cf4
    2888:	e8 0e 19 00 00       	call   419b <mkdir>
    288d:	83 c4 10             	add    $0x10,%esp
    2890:	85 c0                	test   %eax,%eax
    2892:	0f 84 7e 01 00 00    	je     2a16 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2898:	83 ec 0c             	sub    $0xc,%esp
    289b:	68 19 5d 00 00       	push   $0x5d19
    28a0:	e8 f6 18 00 00       	call   419b <mkdir>
    28a5:	83 c4 10             	add    $0x10,%esp
    28a8:	85 c0                	test   %eax,%eax
    28aa:	0f 84 67 03 00 00    	je     2c17 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    28b0:	83 ec 0c             	sub    $0xc,%esp
    28b3:	68 40 5c 00 00       	push   $0x5c40
    28b8:	e8 de 18 00 00       	call   419b <mkdir>
    28bd:	83 c4 10             	add    $0x10,%esp
    28c0:	85 c0                	test   %eax,%eax
    28c2:	0f 84 3c 03 00 00    	je     2c04 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    28c8:	83 ec 0c             	sub    $0xc,%esp
    28cb:	68 19 5d 00 00       	push   $0x5d19
    28d0:	e8 ae 18 00 00       	call   4183 <unlink>
    28d5:	83 c4 10             	add    $0x10,%esp
    28d8:	85 c0                	test   %eax,%eax
    28da:	0f 84 11 03 00 00    	je     2bf1 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    28e0:	83 ec 0c             	sub    $0xc,%esp
    28e3:	68 f4 5c 00 00       	push   $0x5cf4
    28e8:	e8 96 18 00 00       	call   4183 <unlink>
    28ed:	83 c4 10             	add    $0x10,%esp
    28f0:	85 c0                	test   %eax,%eax
    28f2:	0f 84 e6 02 00 00    	je     2bde <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    28f8:	83 ec 0c             	sub    $0xc,%esp
    28fb:	68 df 5b 00 00       	push   $0x5bdf
    2900:	e8 9e 18 00 00       	call   41a3 <chdir>
    2905:	83 c4 10             	add    $0x10,%esp
    2908:	85 c0                	test   %eax,%eax
    290a:	0f 84 bb 02 00 00    	je     2bcb <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    2910:	83 ec 0c             	sub    $0xc,%esp
    2913:	68 8b 5d 00 00       	push   $0x5d8b
    2918:	e8 86 18 00 00       	call   41a3 <chdir>
    291d:	83 c4 10             	add    $0x10,%esp
    2920:	85 c0                	test   %eax,%eax
    2922:	0f 84 90 02 00 00    	je     2bb8 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    2928:	83 ec 0c             	sub    $0xc,%esp
    292b:	68 40 5c 00 00       	push   $0x5c40
    2930:	e8 4e 18 00 00       	call   4183 <unlink>
    2935:	83 c4 10             	add    $0x10,%esp
    2938:	85 c0                	test   %eax,%eax
    293a:	0f 85 9d 00 00 00    	jne    29dd <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    2940:	83 ec 0c             	sub    $0xc,%esp
    2943:	68 df 5b 00 00       	push   $0x5bdf
    2948:	e8 36 18 00 00       	call   4183 <unlink>
    294d:	83 c4 10             	add    $0x10,%esp
    2950:	85 c0                	test   %eax,%eax
    2952:	0f 85 4d 02 00 00    	jne    2ba5 <subdir+0x635>
  if(unlink("dd") == 0){
    2958:	83 ec 0c             	sub    $0xc,%esp
    295b:	68 a6 5c 00 00       	push   $0x5ca6
    2960:	e8 1e 18 00 00       	call   4183 <unlink>
    2965:	83 c4 10             	add    $0x10,%esp
    2968:	85 c0                	test   %eax,%eax
    296a:	0f 84 22 02 00 00    	je     2b92 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2970:	83 ec 0c             	sub    $0xc,%esp
    2973:	68 bb 5b 00 00       	push   $0x5bbb
    2978:	e8 06 18 00 00       	call   4183 <unlink>
    297d:	83 c4 10             	add    $0x10,%esp
    2980:	85 c0                	test   %eax,%eax
    2982:	0f 88 f7 01 00 00    	js     2b7f <subdir+0x60f>
  if(unlink("dd") < 0){
    2988:	83 ec 0c             	sub    $0xc,%esp
    298b:	68 a6 5c 00 00       	push   $0x5ca6
    2990:	e8 ee 17 00 00       	call   4183 <unlink>
    2995:	83 c4 10             	add    $0x10,%esp
    2998:	85 c0                	test   %eax,%eax
    299a:	0f 88 cc 01 00 00    	js     2b6c <subdir+0x5fc>
  printf(1, "subdir ok\n");
    29a0:	83 ec 08             	sub    $0x8,%esp
    29a3:	68 88 5e 00 00       	push   $0x5e88
    29a8:	6a 01                	push   $0x1
    29aa:	e8 01 19 00 00       	call   42b0 <printf>
}
    29af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    29b2:	83 c4 10             	add    $0x10,%esp
    29b5:	c9                   	leave
    29b6:	c3                   	ret
    printf(1, "dd/dd/../ff wrong content\n");
    29b7:	50                   	push   %eax
    29b8:	50                   	push   %eax
    29b9:	68 25 5c 00 00       	push   $0x5c25
    29be:	6a 01                	push   $0x1
    29c0:	e8 eb 18 00 00       	call   42b0 <printf>
    exit();
    29c5:	e8 69 17 00 00       	call   4133 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    29ca:	50                   	push   %eax
    29cb:	50                   	push   %eax
    29cc:	68 80 5c 00 00       	push   $0x5c80
    29d1:	6a 01                	push   $0x1
    29d3:	e8 d8 18 00 00       	call   42b0 <printf>
    exit();
    29d8:	e8 56 17 00 00       	call   4133 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    29dd:	50                   	push   %eax
    29de:	50                   	push   %eax
    29df:	68 4b 5c 00 00       	push   $0x5c4b
    29e4:	6a 01                	push   $0x1
    29e6:	e8 c5 18 00 00       	call   42b0 <printf>
    exit();
    29eb:	e8 43 17 00 00       	call   4133 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    29f0:	51                   	push   %ecx
    29f1:	51                   	push   %ecx
    29f2:	68 fd 5c 00 00       	push   $0x5cfd
    29f7:	6a 01                	push   $0x1
    29f9:	e8 b2 18 00 00       	call   42b0 <printf>
    exit();
    29fe:	e8 30 17 00 00       	call   4133 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2a03:	53                   	push   %ebx
    2a04:	53                   	push   %ebx
    2a05:	68 54 4e 00 00       	push   $0x4e54
    2a0a:	6a 01                	push   $0x1
    2a0c:	e8 9f 18 00 00       	call   42b0 <printf>
    exit();
    2a11:	e8 1d 17 00 00       	call   4133 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2a16:	51                   	push   %ecx
    2a17:	51                   	push   %ecx
    2a18:	68 91 5d 00 00       	push   $0x5d91
    2a1d:	6a 01                	push   $0x1
    2a1f:	e8 8c 18 00 00       	call   42b0 <printf>
    exit();
    2a24:	e8 0a 17 00 00       	call   4133 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2a29:	53                   	push   %ebx
    2a2a:	53                   	push   %ebx
    2a2b:	68 c4 4e 00 00       	push   $0x4ec4
    2a30:	6a 01                	push   $0x1
    2a32:	e8 79 18 00 00       	call   42b0 <printf>
    exit();
    2a37:	e8 f7 16 00 00       	call   4133 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    2a3c:	50                   	push   %eax
    2a3d:	50                   	push   %eax
    2a3e:	68 0c 5c 00 00       	push   $0x5c0c
    2a43:	6a 01                	push   $0x1
    2a45:	e8 66 18 00 00       	call   42b0 <printf>
    exit();
    2a4a:	e8 e4 16 00 00       	call   4133 <exit>
    printf(1, "create dd/dd/ff failed\n");
    2a4f:	51                   	push   %ecx
    2a50:	51                   	push   %ecx
    2a51:	68 e5 5b 00 00       	push   $0x5be5
    2a56:	6a 01                	push   $0x1
    2a58:	e8 53 18 00 00       	call   42b0 <printf>
    exit();
    2a5d:	e8 d1 16 00 00       	call   4133 <exit>
    printf(1, "chdir ./.. failed\n");
    2a62:	50                   	push   %eax
    2a63:	50                   	push   %eax
    2a64:	68 ae 5c 00 00       	push   $0x5cae
    2a69:	6a 01                	push   $0x1
    2a6b:	e8 40 18 00 00       	call   42b0 <printf>
    exit();
    2a70:	e8 be 16 00 00       	call   4133 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2a75:	52                   	push   %edx
    2a76:	52                   	push   %edx
    2a77:	68 0c 4e 00 00       	push   $0x4e0c
    2a7c:	6a 01                	push   $0x1
    2a7e:	e8 2d 18 00 00       	call   42b0 <printf>
    exit();
    2a83:	e8 ab 16 00 00       	call   4133 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2a88:	50                   	push   %eax
    2a89:	50                   	push   %eax
    2a8a:	68 a0 4e 00 00       	push   $0x4ea0
    2a8f:	6a 01                	push   $0x1
    2a91:	e8 1a 18 00 00       	call   42b0 <printf>
    exit();
    2a96:	e8 98 16 00 00       	call   4133 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2a9b:	50                   	push   %eax
    2a9c:	50                   	push   %eax
    2a9d:	68 7c 4e 00 00       	push   $0x4e7c
    2aa2:	6a 01                	push   $0x1
    2aa4:	e8 07 18 00 00       	call   42b0 <printf>
    exit();
    2aa9:	e8 85 16 00 00       	call   4133 <exit>
    printf(1, "open dd wronly succeeded!\n");
    2aae:	50                   	push   %eax
    2aaf:	50                   	push   %eax
    2ab0:	68 6d 5d 00 00       	push   $0x5d6d
    2ab5:	6a 01                	push   $0x1
    2ab7:	e8 f4 17 00 00       	call   42b0 <printf>
    exit();
    2abc:	e8 72 16 00 00       	call   4133 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2ac1:	50                   	push   %eax
    2ac2:	50                   	push   %eax
    2ac3:	68 54 5d 00 00       	push   $0x5d54
    2ac8:	6a 01                	push   $0x1
    2aca:	e8 e1 17 00 00       	call   42b0 <printf>
    exit();
    2acf:	e8 5f 16 00 00       	call   4133 <exit>
    printf(1, "create dd succeeded!\n");
    2ad4:	50                   	push   %eax
    2ad5:	50                   	push   %eax
    2ad6:	68 3e 5d 00 00       	push   $0x5d3e
    2adb:	6a 01                	push   $0x1
    2add:	e8 ce 17 00 00       	call   42b0 <printf>
    exit();
    2ae2:	e8 4c 16 00 00       	call   4133 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    2ae7:	52                   	push   %edx
    2ae8:	52                   	push   %edx
    2ae9:	68 22 5d 00 00       	push   $0x5d22
    2aee:	6a 01                	push   $0x1
    2af0:	e8 bb 17 00 00       	call   42b0 <printf>
    exit();
    2af5:	e8 39 16 00 00       	call   4133 <exit>
    printf(1, "chdir dd failed\n");
    2afa:	50                   	push   %eax
    2afb:	50                   	push   %eax
    2afc:	68 63 5c 00 00       	push   $0x5c63
    2b01:	6a 01                	push   $0x1
    2b03:	e8 a8 17 00 00       	call   42b0 <printf>
    exit();
    2b08:	e8 26 16 00 00       	call   4133 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    2b0d:	50                   	push   %eax
    2b0e:	50                   	push   %eax
    2b0f:	68 30 4e 00 00       	push   $0x4e30
    2b14:	6a 01                	push   $0x1
    2b16:	e8 95 17 00 00       	call   42b0 <printf>
    exit();
    2b1b:	e8 13 16 00 00       	call   4133 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    2b20:	53                   	push   %ebx
    2b21:	53                   	push   %ebx
    2b22:	68 c1 5b 00 00       	push   $0x5bc1
    2b27:	6a 01                	push   $0x1
    2b29:	e8 82 17 00 00       	call   42b0 <printf>
    exit();
    2b2e:	e8 00 16 00 00       	call   4133 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2b33:	50                   	push   %eax
    2b34:	50                   	push   %eax
    2b35:	68 e4 4d 00 00       	push   $0x4de4
    2b3a:	6a 01                	push   $0x1
    2b3c:	e8 6f 17 00 00       	call   42b0 <printf>
    exit();
    2b41:	e8 ed 15 00 00       	call   4133 <exit>
    printf(1, "create dd/ff failed\n");
    2b46:	50                   	push   %eax
    2b47:	50                   	push   %eax
    2b48:	68 a5 5b 00 00       	push   $0x5ba5
    2b4d:	6a 01                	push   $0x1
    2b4f:	e8 5c 17 00 00       	call   42b0 <printf>
    exit();
    2b54:	e8 da 15 00 00       	call   4133 <exit>
    printf(1, "subdir mkdir dd failed\n");
    2b59:	50                   	push   %eax
    2b5a:	50                   	push   %eax
    2b5b:	68 8d 5b 00 00       	push   $0x5b8d
    2b60:	6a 01                	push   $0x1
    2b62:	e8 49 17 00 00       	call   42b0 <printf>
    exit();
    2b67:	e8 c7 15 00 00       	call   4133 <exit>
    printf(1, "unlink dd failed\n");
    2b6c:	50                   	push   %eax
    2b6d:	50                   	push   %eax
    2b6e:	68 76 5e 00 00       	push   $0x5e76
    2b73:	6a 01                	push   $0x1
    2b75:	e8 36 17 00 00       	call   42b0 <printf>
    exit();
    2b7a:	e8 b4 15 00 00       	call   4133 <exit>
    printf(1, "unlink dd/dd failed\n");
    2b7f:	52                   	push   %edx
    2b80:	52                   	push   %edx
    2b81:	68 61 5e 00 00       	push   $0x5e61
    2b86:	6a 01                	push   $0x1
    2b88:	e8 23 17 00 00       	call   42b0 <printf>
    exit();
    2b8d:	e8 a1 15 00 00       	call   4133 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2b92:	51                   	push   %ecx
    2b93:	51                   	push   %ecx
    2b94:	68 e8 4e 00 00       	push   $0x4ee8
    2b99:	6a 01                	push   $0x1
    2b9b:	e8 10 17 00 00       	call   42b0 <printf>
    exit();
    2ba0:	e8 8e 15 00 00       	call   4133 <exit>
    printf(1, "unlink dd/ff failed\n");
    2ba5:	53                   	push   %ebx
    2ba6:	53                   	push   %ebx
    2ba7:	68 4c 5e 00 00       	push   $0x5e4c
    2bac:	6a 01                	push   $0x1
    2bae:	e8 fd 16 00 00       	call   42b0 <printf>
    exit();
    2bb3:	e8 7b 15 00 00       	call   4133 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2bb8:	50                   	push   %eax
    2bb9:	50                   	push   %eax
    2bba:	68 34 5e 00 00       	push   $0x5e34
    2bbf:	6a 01                	push   $0x1
    2bc1:	e8 ea 16 00 00       	call   42b0 <printf>
    exit();
    2bc6:	e8 68 15 00 00       	call   4133 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    2bcb:	50                   	push   %eax
    2bcc:	50                   	push   %eax
    2bcd:	68 1c 5e 00 00       	push   $0x5e1c
    2bd2:	6a 01                	push   $0x1
    2bd4:	e8 d7 16 00 00       	call   42b0 <printf>
    exit();
    2bd9:	e8 55 15 00 00       	call   4133 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2bde:	50                   	push   %eax
    2bdf:	50                   	push   %eax
    2be0:	68 00 5e 00 00       	push   $0x5e00
    2be5:	6a 01                	push   $0x1
    2be7:	e8 c4 16 00 00       	call   42b0 <printf>
    exit();
    2bec:	e8 42 15 00 00       	call   4133 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2bf1:	50                   	push   %eax
    2bf2:	50                   	push   %eax
    2bf3:	68 e4 5d 00 00       	push   $0x5de4
    2bf8:	6a 01                	push   $0x1
    2bfa:	e8 b1 16 00 00       	call   42b0 <printf>
    exit();
    2bff:	e8 2f 15 00 00       	call   4133 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2c04:	50                   	push   %eax
    2c05:	50                   	push   %eax
    2c06:	68 c7 5d 00 00       	push   $0x5dc7
    2c0b:	6a 01                	push   $0x1
    2c0d:	e8 9e 16 00 00       	call   42b0 <printf>
    exit();
    2c12:	e8 1c 15 00 00       	call   4133 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2c17:	52                   	push   %edx
    2c18:	52                   	push   %edx
    2c19:	68 ac 5d 00 00       	push   $0x5dac
    2c1e:	6a 01                	push   $0x1
    2c20:	e8 8b 16 00 00       	call   42b0 <printf>
    exit();
    2c25:	e8 09 15 00 00       	call   4133 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    2c2a:	51                   	push   %ecx
    2c2b:	51                   	push   %ecx
    2c2c:	68 d9 5c 00 00       	push   $0x5cd9
    2c31:	6a 01                	push   $0x1
    2c33:	e8 78 16 00 00       	call   42b0 <printf>
    exit();
    2c38:	e8 f6 14 00 00       	call   4133 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    2c3d:	53                   	push   %ebx
    2c3e:	53                   	push   %ebx
    2c3f:	68 c1 5c 00 00       	push   $0x5cc1
    2c44:	6a 01                	push   $0x1
    2c46:	e8 65 16 00 00       	call   42b0 <printf>
    exit();
    2c4b:	e8 e3 14 00 00       	call   4133 <exit>

00002c50 <bigwrite>:
{
    2c50:	55                   	push   %ebp
    2c51:	89 e5                	mov    %esp,%ebp
    2c53:	56                   	push   %esi
    2c54:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    2c55:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    2c5a:	83 ec 08             	sub    $0x8,%esp
    2c5d:	68 93 5e 00 00       	push   $0x5e93
    2c62:	6a 01                	push   $0x1
    2c64:	e8 47 16 00 00       	call   42b0 <printf>
  unlink("bigwrite");
    2c69:	c7 04 24 a2 5e 00 00 	movl   $0x5ea2,(%esp)
    2c70:	e8 0e 15 00 00       	call   4183 <unlink>
    2c75:	83 c4 10             	add    $0x10,%esp
    2c78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    2c7f:	00 
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2c80:	83 ec 08             	sub    $0x8,%esp
    2c83:	68 02 02 00 00       	push   $0x202
    2c88:	68 a2 5e 00 00       	push   $0x5ea2
    2c8d:	e8 e1 14 00 00       	call   4173 <open>
    if(fd < 0){
    2c92:	83 c4 10             	add    $0x10,%esp
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2c95:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2c97:	85 c0                	test   %eax,%eax
    2c99:	78 7e                	js     2d19 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    2c9b:	83 ec 04             	sub    $0x4,%esp
    2c9e:	53                   	push   %ebx
    2c9f:	68 c0 95 00 00       	push   $0x95c0
    2ca4:	50                   	push   %eax
    2ca5:	e8 a9 14 00 00       	call   4153 <write>
      if(cc != sz){
    2caa:	83 c4 10             	add    $0x10,%esp
    2cad:	39 c3                	cmp    %eax,%ebx
    2caf:	75 55                	jne    2d06 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    2cb1:	83 ec 04             	sub    $0x4,%esp
    2cb4:	53                   	push   %ebx
    2cb5:	68 c0 95 00 00       	push   $0x95c0
    2cba:	56                   	push   %esi
    2cbb:	e8 93 14 00 00       	call   4153 <write>
      if(cc != sz){
    2cc0:	83 c4 10             	add    $0x10,%esp
    2cc3:	39 c3                	cmp    %eax,%ebx
    2cc5:	75 3f                	jne    2d06 <bigwrite+0xb6>
    close(fd);
    2cc7:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    2cca:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2cd0:	56                   	push   %esi
    2cd1:	e8 85 14 00 00       	call   415b <close>
    unlink("bigwrite");
    2cd6:	c7 04 24 a2 5e 00 00 	movl   $0x5ea2,(%esp)
    2cdd:	e8 a1 14 00 00       	call   4183 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2ce2:	83 c4 10             	add    $0x10,%esp
    2ce5:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    2ceb:	75 93                	jne    2c80 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    2ced:	83 ec 08             	sub    $0x8,%esp
    2cf0:	68 d5 5e 00 00       	push   $0x5ed5
    2cf5:	6a 01                	push   $0x1
    2cf7:	e8 b4 15 00 00       	call   42b0 <printf>
}
    2cfc:	83 c4 10             	add    $0x10,%esp
    2cff:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2d02:	5b                   	pop    %ebx
    2d03:	5e                   	pop    %esi
    2d04:	5d                   	pop    %ebp
    2d05:	c3                   	ret
        printf(1, "write(%d) ret %d\n", sz, cc);
    2d06:	50                   	push   %eax
    2d07:	53                   	push   %ebx
    2d08:	68 c3 5e 00 00       	push   $0x5ec3
    2d0d:	6a 01                	push   $0x1
    2d0f:	e8 9c 15 00 00       	call   42b0 <printf>
        exit();
    2d14:	e8 1a 14 00 00       	call   4133 <exit>
      printf(1, "cannot create bigwrite\n");
    2d19:	83 ec 08             	sub    $0x8,%esp
    2d1c:	68 ab 5e 00 00       	push   $0x5eab
    2d21:	6a 01                	push   $0x1
    2d23:	e8 88 15 00 00       	call   42b0 <printf>
      exit();
    2d28:	e8 06 14 00 00       	call   4133 <exit>
    2d2d:	8d 76 00             	lea    0x0(%esi),%esi

00002d30 <bigfile>:
{
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	57                   	push   %edi
    2d34:	56                   	push   %esi
    2d35:	53                   	push   %ebx
    2d36:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    2d39:	68 e2 5e 00 00       	push   $0x5ee2
    2d3e:	6a 01                	push   $0x1
    2d40:	e8 6b 15 00 00       	call   42b0 <printf>
  unlink("bigfile");
    2d45:	c7 04 24 fe 5e 00 00 	movl   $0x5efe,(%esp)
    2d4c:	e8 32 14 00 00       	call   4183 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2d51:	58                   	pop    %eax
    2d52:	5a                   	pop    %edx
    2d53:	68 02 02 00 00       	push   $0x202
    2d58:	68 fe 5e 00 00       	push   $0x5efe
    2d5d:	e8 11 14 00 00       	call   4173 <open>
  if(fd < 0){
    2d62:	83 c4 10             	add    $0x10,%esp
    2d65:	85 c0                	test   %eax,%eax
    2d67:	0f 88 5e 01 00 00    	js     2ecb <bigfile+0x19b>
    2d6d:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    2d6f:	31 db                	xor    %ebx,%ebx
    2d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2d78:	83 ec 04             	sub    $0x4,%esp
    2d7b:	68 58 02 00 00       	push   $0x258
    2d80:	53                   	push   %ebx
    2d81:	68 c0 95 00 00       	push   $0x95c0
    2d86:	e8 25 12 00 00       	call   3fb0 <memset>
    if(write(fd, buf, 600) != 600){
    2d8b:	83 c4 0c             	add    $0xc,%esp
    2d8e:	68 58 02 00 00       	push   $0x258
    2d93:	68 c0 95 00 00       	push   $0x95c0
    2d98:	56                   	push   %esi
    2d99:	e8 b5 13 00 00       	call   4153 <write>
    2d9e:	83 c4 10             	add    $0x10,%esp
    2da1:	3d 58 02 00 00       	cmp    $0x258,%eax
    2da6:	0f 85 f8 00 00 00    	jne    2ea4 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    2dac:	83 c3 01             	add    $0x1,%ebx
    2daf:	83 fb 14             	cmp    $0x14,%ebx
    2db2:	75 c4                	jne    2d78 <bigfile+0x48>
  close(fd);
    2db4:	83 ec 0c             	sub    $0xc,%esp
    2db7:	56                   	push   %esi
    2db8:	e8 9e 13 00 00       	call   415b <close>
  fd = open("bigfile", 0);
    2dbd:	5e                   	pop    %esi
    2dbe:	5f                   	pop    %edi
    2dbf:	6a 00                	push   $0x0
    2dc1:	68 fe 5e 00 00       	push   $0x5efe
    2dc6:	e8 a8 13 00 00       	call   4173 <open>
  if(fd < 0){
    2dcb:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", 0);
    2dce:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2dd0:	85 c0                	test   %eax,%eax
    2dd2:	0f 88 e0 00 00 00    	js     2eb8 <bigfile+0x188>
  total = 0;
    2dd8:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    2dda:	31 ff                	xor    %edi,%edi
    2ddc:	eb 30                	jmp    2e0e <bigfile+0xde>
    2dde:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2de0:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2de5:	0f 85 91 00 00 00    	jne    2e7c <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    2deb:	89 fa                	mov    %edi,%edx
    2ded:	0f be 05 c0 95 00 00 	movsbl 0x95c0,%eax
    2df4:	d1 fa                	sar    $1,%edx
    2df6:	39 d0                	cmp    %edx,%eax
    2df8:	75 6e                	jne    2e68 <bigfile+0x138>
    2dfa:	0f be 15 eb 96 00 00 	movsbl 0x96eb,%edx
    2e01:	39 d0                	cmp    %edx,%eax
    2e03:	75 63                	jne    2e68 <bigfile+0x138>
    total += cc;
    2e05:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    2e0b:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    2e0e:	83 ec 04             	sub    $0x4,%esp
    2e11:	68 2c 01 00 00       	push   $0x12c
    2e16:	68 c0 95 00 00       	push   $0x95c0
    2e1b:	56                   	push   %esi
    2e1c:	e8 2a 13 00 00       	call   414b <read>
    if(cc < 0){
    2e21:	83 c4 10             	add    $0x10,%esp
    2e24:	85 c0                	test   %eax,%eax
    2e26:	78 68                	js     2e90 <bigfile+0x160>
    if(cc == 0)
    2e28:	75 b6                	jne    2de0 <bigfile+0xb0>
  close(fd);
    2e2a:	83 ec 0c             	sub    $0xc,%esp
    2e2d:	56                   	push   %esi
    2e2e:	e8 28 13 00 00       	call   415b <close>
  if(total != 20*600){
    2e33:	83 c4 10             	add    $0x10,%esp
    2e36:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    2e3c:	0f 85 9c 00 00 00    	jne    2ede <bigfile+0x1ae>
  unlink("bigfile");
    2e42:	83 ec 0c             	sub    $0xc,%esp
    2e45:	68 fe 5e 00 00       	push   $0x5efe
    2e4a:	e8 34 13 00 00       	call   4183 <unlink>
  printf(1, "bigfile test ok\n");
    2e4f:	58                   	pop    %eax
    2e50:	5a                   	pop    %edx
    2e51:	68 8d 5f 00 00       	push   $0x5f8d
    2e56:	6a 01                	push   $0x1
    2e58:	e8 53 14 00 00       	call   42b0 <printf>
}
    2e5d:	83 c4 10             	add    $0x10,%esp
    2e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2e63:	5b                   	pop    %ebx
    2e64:	5e                   	pop    %esi
    2e65:	5f                   	pop    %edi
    2e66:	5d                   	pop    %ebp
    2e67:	c3                   	ret
      printf(1, "read bigfile wrong data\n");
    2e68:	83 ec 08             	sub    $0x8,%esp
    2e6b:	68 5a 5f 00 00       	push   $0x5f5a
    2e70:	6a 01                	push   $0x1
    2e72:	e8 39 14 00 00       	call   42b0 <printf>
      exit();
    2e77:	e8 b7 12 00 00       	call   4133 <exit>
      printf(1, "short read bigfile\n");
    2e7c:	83 ec 08             	sub    $0x8,%esp
    2e7f:	68 46 5f 00 00       	push   $0x5f46
    2e84:	6a 01                	push   $0x1
    2e86:	e8 25 14 00 00       	call   42b0 <printf>
      exit();
    2e8b:	e8 a3 12 00 00       	call   4133 <exit>
      printf(1, "read bigfile failed\n");
    2e90:	83 ec 08             	sub    $0x8,%esp
    2e93:	68 31 5f 00 00       	push   $0x5f31
    2e98:	6a 01                	push   $0x1
    2e9a:	e8 11 14 00 00       	call   42b0 <printf>
      exit();
    2e9f:	e8 8f 12 00 00       	call   4133 <exit>
      printf(1, "write bigfile failed\n");
    2ea4:	83 ec 08             	sub    $0x8,%esp
    2ea7:	68 06 5f 00 00       	push   $0x5f06
    2eac:	6a 01                	push   $0x1
    2eae:	e8 fd 13 00 00       	call   42b0 <printf>
      exit();
    2eb3:	e8 7b 12 00 00       	call   4133 <exit>
    printf(1, "cannot open bigfile\n");
    2eb8:	53                   	push   %ebx
    2eb9:	53                   	push   %ebx
    2eba:	68 1c 5f 00 00       	push   $0x5f1c
    2ebf:	6a 01                	push   $0x1
    2ec1:	e8 ea 13 00 00       	call   42b0 <printf>
    exit();
    2ec6:	e8 68 12 00 00       	call   4133 <exit>
    printf(1, "cannot create bigfile");
    2ecb:	50                   	push   %eax
    2ecc:	50                   	push   %eax
    2ecd:	68 f0 5e 00 00       	push   $0x5ef0
    2ed2:	6a 01                	push   $0x1
    2ed4:	e8 d7 13 00 00       	call   42b0 <printf>
    exit();
    2ed9:	e8 55 12 00 00       	call   4133 <exit>
    printf(1, "read bigfile wrong total\n");
    2ede:	51                   	push   %ecx
    2edf:	51                   	push   %ecx
    2ee0:	68 73 5f 00 00       	push   $0x5f73
    2ee5:	6a 01                	push   $0x1
    2ee7:	e8 c4 13 00 00       	call   42b0 <printf>
    exit();
    2eec:	e8 42 12 00 00       	call   4133 <exit>
    2ef1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    2ef8:	00 
    2ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002f00 <fourteen>:
{
    2f00:	55                   	push   %ebp
    2f01:	89 e5                	mov    %esp,%ebp
    2f03:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    2f06:	68 9e 5f 00 00       	push   $0x5f9e
    2f0b:	6a 01                	push   $0x1
    2f0d:	e8 9e 13 00 00       	call   42b0 <printf>
  if(mkdir("12345678901234") != 0){
    2f12:	c7 04 24 d9 5f 00 00 	movl   $0x5fd9,(%esp)
    2f19:	e8 7d 12 00 00       	call   419b <mkdir>
    2f1e:	83 c4 10             	add    $0x10,%esp
    2f21:	85 c0                	test   %eax,%eax
    2f23:	0f 85 97 00 00 00    	jne    2fc0 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    2f29:	83 ec 0c             	sub    $0xc,%esp
    2f2c:	68 08 4f 00 00       	push   $0x4f08
    2f31:	e8 65 12 00 00       	call   419b <mkdir>
    2f36:	83 c4 10             	add    $0x10,%esp
    2f39:	85 c0                	test   %eax,%eax
    2f3b:	0f 85 de 00 00 00    	jne    301f <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2f41:	83 ec 08             	sub    $0x8,%esp
    2f44:	68 00 02 00 00       	push   $0x200
    2f49:	68 58 4f 00 00       	push   $0x4f58
    2f4e:	e8 20 12 00 00       	call   4173 <open>
  if(fd < 0){
    2f53:	83 c4 10             	add    $0x10,%esp
    2f56:	85 c0                	test   %eax,%eax
    2f58:	0f 88 ae 00 00 00    	js     300c <fourteen+0x10c>
  close(fd);
    2f5e:	83 ec 0c             	sub    $0xc,%esp
    2f61:	50                   	push   %eax
    2f62:	e8 f4 11 00 00       	call   415b <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2f67:	58                   	pop    %eax
    2f68:	5a                   	pop    %edx
    2f69:	6a 00                	push   $0x0
    2f6b:	68 c8 4f 00 00       	push   $0x4fc8
    2f70:	e8 fe 11 00 00       	call   4173 <open>
  if(fd < 0){
    2f75:	83 c4 10             	add    $0x10,%esp
    2f78:	85 c0                	test   %eax,%eax
    2f7a:	78 7d                	js     2ff9 <fourteen+0xf9>
  close(fd);
    2f7c:	83 ec 0c             	sub    $0xc,%esp
    2f7f:	50                   	push   %eax
    2f80:	e8 d6 11 00 00       	call   415b <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2f85:	c7 04 24 ca 5f 00 00 	movl   $0x5fca,(%esp)
    2f8c:	e8 0a 12 00 00       	call   419b <mkdir>
    2f91:	83 c4 10             	add    $0x10,%esp
    2f94:	85 c0                	test   %eax,%eax
    2f96:	74 4e                	je     2fe6 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2f98:	83 ec 0c             	sub    $0xc,%esp
    2f9b:	68 64 50 00 00       	push   $0x5064
    2fa0:	e8 f6 11 00 00       	call   419b <mkdir>
    2fa5:	83 c4 10             	add    $0x10,%esp
    2fa8:	85 c0                	test   %eax,%eax
    2faa:	74 27                	je     2fd3 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    2fac:	83 ec 08             	sub    $0x8,%esp
    2faf:	68 e8 5f 00 00       	push   $0x5fe8
    2fb4:	6a 01                	push   $0x1
    2fb6:	e8 f5 12 00 00       	call   42b0 <printf>
}
    2fbb:	83 c4 10             	add    $0x10,%esp
    2fbe:	c9                   	leave
    2fbf:	c3                   	ret
    printf(1, "mkdir 12345678901234 failed\n");
    2fc0:	50                   	push   %eax
    2fc1:	50                   	push   %eax
    2fc2:	68 ad 5f 00 00       	push   $0x5fad
    2fc7:	6a 01                	push   $0x1
    2fc9:	e8 e2 12 00 00       	call   42b0 <printf>
    exit();
    2fce:	e8 60 11 00 00       	call   4133 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2fd3:	50                   	push   %eax
    2fd4:	50                   	push   %eax
    2fd5:	68 84 50 00 00       	push   $0x5084
    2fda:	6a 01                	push   $0x1
    2fdc:	e8 cf 12 00 00       	call   42b0 <printf>
    exit();
    2fe1:	e8 4d 11 00 00       	call   4133 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2fe6:	52                   	push   %edx
    2fe7:	52                   	push   %edx
    2fe8:	68 34 50 00 00       	push   $0x5034
    2fed:	6a 01                	push   $0x1
    2fef:	e8 bc 12 00 00       	call   42b0 <printf>
    exit();
    2ff4:	e8 3a 11 00 00       	call   4133 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2ff9:	51                   	push   %ecx
    2ffa:	51                   	push   %ecx
    2ffb:	68 f8 4f 00 00       	push   $0x4ff8
    3000:	6a 01                	push   $0x1
    3002:	e8 a9 12 00 00       	call   42b0 <printf>
    exit();
    3007:	e8 27 11 00 00       	call   4133 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    300c:	51                   	push   %ecx
    300d:	51                   	push   %ecx
    300e:	68 88 4f 00 00       	push   $0x4f88
    3013:	6a 01                	push   $0x1
    3015:	e8 96 12 00 00       	call   42b0 <printf>
    exit();
    301a:	e8 14 11 00 00       	call   4133 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    301f:	50                   	push   %eax
    3020:	50                   	push   %eax
    3021:	68 28 4f 00 00       	push   $0x4f28
    3026:	6a 01                	push   $0x1
    3028:	e8 83 12 00 00       	call   42b0 <printf>
    exit();
    302d:	e8 01 11 00 00       	call   4133 <exit>
    3032:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3039:	00 
    303a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003040 <rmdot>:
{
    3040:	55                   	push   %ebp
    3041:	89 e5                	mov    %esp,%ebp
    3043:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    3046:	68 f5 5f 00 00       	push   $0x5ff5
    304b:	6a 01                	push   $0x1
    304d:	e8 5e 12 00 00       	call   42b0 <printf>
  if(mkdir("dots") != 0){
    3052:	c7 04 24 01 60 00 00 	movl   $0x6001,(%esp)
    3059:	e8 3d 11 00 00       	call   419b <mkdir>
    305e:	83 c4 10             	add    $0x10,%esp
    3061:	85 c0                	test   %eax,%eax
    3063:	0f 85 b0 00 00 00    	jne    3119 <rmdot+0xd9>
  if(chdir("dots") != 0){
    3069:	83 ec 0c             	sub    $0xc,%esp
    306c:	68 01 60 00 00       	push   $0x6001
    3071:	e8 2d 11 00 00       	call   41a3 <chdir>
    3076:	83 c4 10             	add    $0x10,%esp
    3079:	85 c0                	test   %eax,%eax
    307b:	0f 85 1d 01 00 00    	jne    319e <rmdot+0x15e>
  if(unlink(".") == 0){
    3081:	83 ec 0c             	sub    $0xc,%esp
    3084:	68 ac 5c 00 00       	push   $0x5cac
    3089:	e8 f5 10 00 00       	call   4183 <unlink>
    308e:	83 c4 10             	add    $0x10,%esp
    3091:	85 c0                	test   %eax,%eax
    3093:	0f 84 f2 00 00 00    	je     318b <rmdot+0x14b>
  if(unlink("..") == 0){
    3099:	83 ec 0c             	sub    $0xc,%esp
    309c:	68 ab 5c 00 00       	push   $0x5cab
    30a1:	e8 dd 10 00 00       	call   4183 <unlink>
    30a6:	83 c4 10             	add    $0x10,%esp
    30a9:	85 c0                	test   %eax,%eax
    30ab:	0f 84 c7 00 00 00    	je     3178 <rmdot+0x138>
  if(chdir("/") != 0){
    30b1:	83 ec 0c             	sub    $0xc,%esp
    30b4:	68 7f 54 00 00       	push   $0x547f
    30b9:	e8 e5 10 00 00       	call   41a3 <chdir>
    30be:	83 c4 10             	add    $0x10,%esp
    30c1:	85 c0                	test   %eax,%eax
    30c3:	0f 85 9c 00 00 00    	jne    3165 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    30c9:	83 ec 0c             	sub    $0xc,%esp
    30cc:	68 49 60 00 00       	push   $0x6049
    30d1:	e8 ad 10 00 00       	call   4183 <unlink>
    30d6:	83 c4 10             	add    $0x10,%esp
    30d9:	85 c0                	test   %eax,%eax
    30db:	74 75                	je     3152 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    30dd:	83 ec 0c             	sub    $0xc,%esp
    30e0:	68 67 60 00 00       	push   $0x6067
    30e5:	e8 99 10 00 00       	call   4183 <unlink>
    30ea:	83 c4 10             	add    $0x10,%esp
    30ed:	85 c0                	test   %eax,%eax
    30ef:	74 4e                	je     313f <rmdot+0xff>
  if(unlink("dots") != 0){
    30f1:	83 ec 0c             	sub    $0xc,%esp
    30f4:	68 01 60 00 00       	push   $0x6001
    30f9:	e8 85 10 00 00       	call   4183 <unlink>
    30fe:	83 c4 10             	add    $0x10,%esp
    3101:	85 c0                	test   %eax,%eax
    3103:	75 27                	jne    312c <rmdot+0xec>
  printf(1, "rmdot ok\n");
    3105:	83 ec 08             	sub    $0x8,%esp
    3108:	68 9c 60 00 00       	push   $0x609c
    310d:	6a 01                	push   $0x1
    310f:	e8 9c 11 00 00       	call   42b0 <printf>
}
    3114:	83 c4 10             	add    $0x10,%esp
    3117:	c9                   	leave
    3118:	c3                   	ret
    printf(1, "mkdir dots failed\n");
    3119:	50                   	push   %eax
    311a:	50                   	push   %eax
    311b:	68 06 60 00 00       	push   $0x6006
    3120:	6a 01                	push   $0x1
    3122:	e8 89 11 00 00       	call   42b0 <printf>
    exit();
    3127:	e8 07 10 00 00       	call   4133 <exit>
    printf(1, "unlink dots failed!\n");
    312c:	50                   	push   %eax
    312d:	50                   	push   %eax
    312e:	68 87 60 00 00       	push   $0x6087
    3133:	6a 01                	push   $0x1
    3135:	e8 76 11 00 00       	call   42b0 <printf>
    exit();
    313a:	e8 f4 0f 00 00       	call   4133 <exit>
    printf(1, "unlink dots/.. worked!\n");
    313f:	52                   	push   %edx
    3140:	52                   	push   %edx
    3141:	68 6f 60 00 00       	push   $0x606f
    3146:	6a 01                	push   $0x1
    3148:	e8 63 11 00 00       	call   42b0 <printf>
    exit();
    314d:	e8 e1 0f 00 00       	call   4133 <exit>
    printf(1, "unlink dots/. worked!\n");
    3152:	51                   	push   %ecx
    3153:	51                   	push   %ecx
    3154:	68 50 60 00 00       	push   $0x6050
    3159:	6a 01                	push   $0x1
    315b:	e8 50 11 00 00       	call   42b0 <printf>
    exit();
    3160:	e8 ce 0f 00 00       	call   4133 <exit>
    printf(1, "chdir / failed\n");
    3165:	50                   	push   %eax
    3166:	50                   	push   %eax
    3167:	68 81 54 00 00       	push   $0x5481
    316c:	6a 01                	push   $0x1
    316e:	e8 3d 11 00 00       	call   42b0 <printf>
    exit();
    3173:	e8 bb 0f 00 00       	call   4133 <exit>
    printf(1, "rm .. worked!\n");
    3178:	50                   	push   %eax
    3179:	50                   	push   %eax
    317a:	68 3a 60 00 00       	push   $0x603a
    317f:	6a 01                	push   $0x1
    3181:	e8 2a 11 00 00       	call   42b0 <printf>
    exit();
    3186:	e8 a8 0f 00 00       	call   4133 <exit>
    printf(1, "rm . worked!\n");
    318b:	50                   	push   %eax
    318c:	50                   	push   %eax
    318d:	68 2c 60 00 00       	push   $0x602c
    3192:	6a 01                	push   $0x1
    3194:	e8 17 11 00 00       	call   42b0 <printf>
    exit();
    3199:	e8 95 0f 00 00       	call   4133 <exit>
    printf(1, "chdir dots failed\n");
    319e:	50                   	push   %eax
    319f:	50                   	push   %eax
    31a0:	68 19 60 00 00       	push   $0x6019
    31a5:	6a 01                	push   $0x1
    31a7:	e8 04 11 00 00       	call   42b0 <printf>
    exit();
    31ac:	e8 82 0f 00 00       	call   4133 <exit>
    31b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    31b8:	00 
    31b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000031c0 <dirfile>:
{
    31c0:	55                   	push   %ebp
    31c1:	89 e5                	mov    %esp,%ebp
    31c3:	53                   	push   %ebx
    31c4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    31c7:	68 a6 60 00 00       	push   $0x60a6
    31cc:	6a 01                	push   $0x1
    31ce:	e8 dd 10 00 00       	call   42b0 <printf>
  fd = open("dirfile", O_CREATE);
    31d3:	5b                   	pop    %ebx
    31d4:	58                   	pop    %eax
    31d5:	68 00 02 00 00       	push   $0x200
    31da:	68 b3 60 00 00       	push   $0x60b3
    31df:	e8 8f 0f 00 00       	call   4173 <open>
  if(fd < 0){
    31e4:	83 c4 10             	add    $0x10,%esp
    31e7:	85 c0                	test   %eax,%eax
    31e9:	0f 88 43 01 00 00    	js     3332 <dirfile+0x172>
  close(fd);
    31ef:	83 ec 0c             	sub    $0xc,%esp
    31f2:	50                   	push   %eax
    31f3:	e8 63 0f 00 00       	call   415b <close>
  if(chdir("dirfile") == 0){
    31f8:	c7 04 24 b3 60 00 00 	movl   $0x60b3,(%esp)
    31ff:	e8 9f 0f 00 00       	call   41a3 <chdir>
    3204:	83 c4 10             	add    $0x10,%esp
    3207:	85 c0                	test   %eax,%eax
    3209:	0f 84 10 01 00 00    	je     331f <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    320f:	83 ec 08             	sub    $0x8,%esp
    3212:	6a 00                	push   $0x0
    3214:	68 ec 60 00 00       	push   $0x60ec
    3219:	e8 55 0f 00 00       	call   4173 <open>
  if(fd >= 0){
    321e:	83 c4 10             	add    $0x10,%esp
    3221:	85 c0                	test   %eax,%eax
    3223:	0f 89 e3 00 00 00    	jns    330c <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    3229:	83 ec 08             	sub    $0x8,%esp
    322c:	68 00 02 00 00       	push   $0x200
    3231:	68 ec 60 00 00       	push   $0x60ec
    3236:	e8 38 0f 00 00       	call   4173 <open>
  if(fd >= 0){
    323b:	83 c4 10             	add    $0x10,%esp
    323e:	85 c0                	test   %eax,%eax
    3240:	0f 89 c6 00 00 00    	jns    330c <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    3246:	83 ec 0c             	sub    $0xc,%esp
    3249:	68 ec 60 00 00       	push   $0x60ec
    324e:	e8 48 0f 00 00       	call   419b <mkdir>
    3253:	83 c4 10             	add    $0x10,%esp
    3256:	85 c0                	test   %eax,%eax
    3258:	0f 84 46 01 00 00    	je     33a4 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    325e:	83 ec 0c             	sub    $0xc,%esp
    3261:	68 ec 60 00 00       	push   $0x60ec
    3266:	e8 18 0f 00 00       	call   4183 <unlink>
    326b:	83 c4 10             	add    $0x10,%esp
    326e:	85 c0                	test   %eax,%eax
    3270:	0f 84 1b 01 00 00    	je     3391 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    3276:	83 ec 08             	sub    $0x8,%esp
    3279:	68 ec 60 00 00       	push   $0x60ec
    327e:	68 50 61 00 00       	push   $0x6150
    3283:	e8 0b 0f 00 00       	call   4193 <link>
    3288:	83 c4 10             	add    $0x10,%esp
    328b:	85 c0                	test   %eax,%eax
    328d:	0f 84 eb 00 00 00    	je     337e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    3293:	83 ec 0c             	sub    $0xc,%esp
    3296:	68 b3 60 00 00       	push   $0x60b3
    329b:	e8 e3 0e 00 00       	call   4183 <unlink>
    32a0:	83 c4 10             	add    $0x10,%esp
    32a3:	85 c0                	test   %eax,%eax
    32a5:	0f 85 c0 00 00 00    	jne    336b <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    32ab:	83 ec 08             	sub    $0x8,%esp
    32ae:	6a 02                	push   $0x2
    32b0:	68 ac 5c 00 00       	push   $0x5cac
    32b5:	e8 b9 0e 00 00       	call   4173 <open>
  if(fd >= 0){
    32ba:	83 c4 10             	add    $0x10,%esp
    32bd:	85 c0                	test   %eax,%eax
    32bf:	0f 89 93 00 00 00    	jns    3358 <dirfile+0x198>
  fd = open(".", 0);
    32c5:	83 ec 08             	sub    $0x8,%esp
    32c8:	6a 00                	push   $0x0
    32ca:	68 ac 5c 00 00       	push   $0x5cac
    32cf:	e8 9f 0e 00 00       	call   4173 <open>
  if(write(fd, "x", 1) > 0){
    32d4:	83 c4 0c             	add    $0xc,%esp
    32d7:	6a 01                	push   $0x1
  fd = open(".", 0);
    32d9:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    32db:	68 8f 5d 00 00       	push   $0x5d8f
    32e0:	50                   	push   %eax
    32e1:	e8 6d 0e 00 00       	call   4153 <write>
    32e6:	83 c4 10             	add    $0x10,%esp
    32e9:	85 c0                	test   %eax,%eax
    32eb:	7f 58                	jg     3345 <dirfile+0x185>
  close(fd);
    32ed:	83 ec 0c             	sub    $0xc,%esp
    32f0:	53                   	push   %ebx
    32f1:	e8 65 0e 00 00       	call   415b <close>
  printf(1, "dir vs file OK\n");
    32f6:	58                   	pop    %eax
    32f7:	5a                   	pop    %edx
    32f8:	68 83 61 00 00       	push   $0x6183
    32fd:	6a 01                	push   $0x1
    32ff:	e8 ac 0f 00 00       	call   42b0 <printf>
}
    3304:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3307:	83 c4 10             	add    $0x10,%esp
    330a:	c9                   	leave
    330b:	c3                   	ret
    printf(1, "create dirfile/xx succeeded!\n");
    330c:	50                   	push   %eax
    330d:	50                   	push   %eax
    330e:	68 f7 60 00 00       	push   $0x60f7
    3313:	6a 01                	push   $0x1
    3315:	e8 96 0f 00 00       	call   42b0 <printf>
    exit();
    331a:	e8 14 0e 00 00       	call   4133 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    331f:	52                   	push   %edx
    3320:	52                   	push   %edx
    3321:	68 d2 60 00 00       	push   $0x60d2
    3326:	6a 01                	push   $0x1
    3328:	e8 83 0f 00 00       	call   42b0 <printf>
    exit();
    332d:	e8 01 0e 00 00       	call   4133 <exit>
    printf(1, "create dirfile failed\n");
    3332:	51                   	push   %ecx
    3333:	51                   	push   %ecx
    3334:	68 bb 60 00 00       	push   $0x60bb
    3339:	6a 01                	push   $0x1
    333b:	e8 70 0f 00 00       	call   42b0 <printf>
    exit();
    3340:	e8 ee 0d 00 00       	call   4133 <exit>
    printf(1, "write . succeeded!\n");
    3345:	51                   	push   %ecx
    3346:	51                   	push   %ecx
    3347:	68 6f 61 00 00       	push   $0x616f
    334c:	6a 01                	push   $0x1
    334e:	e8 5d 0f 00 00       	call   42b0 <printf>
    exit();
    3353:	e8 db 0d 00 00       	call   4133 <exit>
    printf(1, "open . for writing succeeded!\n");
    3358:	53                   	push   %ebx
    3359:	53                   	push   %ebx
    335a:	68 d8 50 00 00       	push   $0x50d8
    335f:	6a 01                	push   $0x1
    3361:	e8 4a 0f 00 00       	call   42b0 <printf>
    exit();
    3366:	e8 c8 0d 00 00       	call   4133 <exit>
    printf(1, "unlink dirfile failed!\n");
    336b:	50                   	push   %eax
    336c:	50                   	push   %eax
    336d:	68 57 61 00 00       	push   $0x6157
    3372:	6a 01                	push   $0x1
    3374:	e8 37 0f 00 00       	call   42b0 <printf>
    exit();
    3379:	e8 b5 0d 00 00       	call   4133 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    337e:	50                   	push   %eax
    337f:	50                   	push   %eax
    3380:	68 b8 50 00 00       	push   $0x50b8
    3385:	6a 01                	push   $0x1
    3387:	e8 24 0f 00 00       	call   42b0 <printf>
    exit();
    338c:	e8 a2 0d 00 00       	call   4133 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    3391:	50                   	push   %eax
    3392:	50                   	push   %eax
    3393:	68 32 61 00 00       	push   $0x6132
    3398:	6a 01                	push   $0x1
    339a:	e8 11 0f 00 00       	call   42b0 <printf>
    exit();
    339f:	e8 8f 0d 00 00       	call   4133 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    33a4:	50                   	push   %eax
    33a5:	50                   	push   %eax
    33a6:	68 15 61 00 00       	push   $0x6115
    33ab:	6a 01                	push   $0x1
    33ad:	e8 fe 0e 00 00       	call   42b0 <printf>
    exit();
    33b2:	e8 7c 0d 00 00       	call   4133 <exit>
    33b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    33be:	00 
    33bf:	90                   	nop

000033c0 <iref>:
{
    33c0:	55                   	push   %ebp
    33c1:	89 e5                	mov    %esp,%ebp
    33c3:	53                   	push   %ebx
  printf(1, "empty file name\n");
    33c4:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    33c9:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    33cc:	68 93 61 00 00       	push   $0x6193
    33d1:	6a 01                	push   $0x1
    33d3:	e8 d8 0e 00 00       	call   42b0 <printf>
    33d8:	83 c4 10             	add    $0x10,%esp
    33db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(mkdir("irefd") != 0){
    33e0:	83 ec 0c             	sub    $0xc,%esp
    33e3:	68 a4 61 00 00       	push   $0x61a4
    33e8:	e8 ae 0d 00 00       	call   419b <mkdir>
    33ed:	83 c4 10             	add    $0x10,%esp
    33f0:	85 c0                	test   %eax,%eax
    33f2:	0f 85 bb 00 00 00    	jne    34b3 <iref+0xf3>
    if(chdir("irefd") != 0){
    33f8:	83 ec 0c             	sub    $0xc,%esp
    33fb:	68 a4 61 00 00       	push   $0x61a4
    3400:	e8 9e 0d 00 00       	call   41a3 <chdir>
    3405:	83 c4 10             	add    $0x10,%esp
    3408:	85 c0                	test   %eax,%eax
    340a:	0f 85 b7 00 00 00    	jne    34c7 <iref+0x107>
    mkdir("");
    3410:	83 ec 0c             	sub    $0xc,%esp
    3413:	68 59 58 00 00       	push   $0x5859
    3418:	e8 7e 0d 00 00       	call   419b <mkdir>
    link("README", "");
    341d:	59                   	pop    %ecx
    341e:	58                   	pop    %eax
    341f:	68 59 58 00 00       	push   $0x5859
    3424:	68 50 61 00 00       	push   $0x6150
    3429:	e8 65 0d 00 00       	call   4193 <link>
    fd = open("", O_CREATE);
    342e:	58                   	pop    %eax
    342f:	5a                   	pop    %edx
    3430:	68 00 02 00 00       	push   $0x200
    3435:	68 59 58 00 00       	push   $0x5859
    343a:	e8 34 0d 00 00       	call   4173 <open>
    if(fd >= 0)
    343f:	83 c4 10             	add    $0x10,%esp
    3442:	85 c0                	test   %eax,%eax
    3444:	78 0c                	js     3452 <iref+0x92>
      close(fd);
    3446:	83 ec 0c             	sub    $0xc,%esp
    3449:	50                   	push   %eax
    344a:	e8 0c 0d 00 00       	call   415b <close>
    344f:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    3452:	83 ec 08             	sub    $0x8,%esp
    3455:	68 00 02 00 00       	push   $0x200
    345a:	68 8e 5d 00 00       	push   $0x5d8e
    345f:	e8 0f 0d 00 00       	call   4173 <open>
    if(fd >= 0)
    3464:	83 c4 10             	add    $0x10,%esp
    3467:	85 c0                	test   %eax,%eax
    3469:	78 0c                	js     3477 <iref+0xb7>
      close(fd);
    346b:	83 ec 0c             	sub    $0xc,%esp
    346e:	50                   	push   %eax
    346f:	e8 e7 0c 00 00       	call   415b <close>
    3474:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    3477:	83 ec 0c             	sub    $0xc,%esp
    347a:	68 8e 5d 00 00       	push   $0x5d8e
    347f:	e8 ff 0c 00 00       	call   4183 <unlink>
  for(i = 0; i < 50 + 1; i++){
    3484:	83 c4 10             	add    $0x10,%esp
    3487:	83 eb 01             	sub    $0x1,%ebx
    348a:	0f 85 50 ff ff ff    	jne    33e0 <iref+0x20>
  chdir("/");
    3490:	83 ec 0c             	sub    $0xc,%esp
    3493:	68 7f 54 00 00       	push   $0x547f
    3498:	e8 06 0d 00 00       	call   41a3 <chdir>
  printf(1, "empty file name OK\n");
    349d:	58                   	pop    %eax
    349e:	5a                   	pop    %edx
    349f:	68 d2 61 00 00       	push   $0x61d2
    34a4:	6a 01                	push   $0x1
    34a6:	e8 05 0e 00 00       	call   42b0 <printf>
}
    34ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    34ae:	83 c4 10             	add    $0x10,%esp
    34b1:	c9                   	leave
    34b2:	c3                   	ret
      printf(1, "mkdir irefd failed\n");
    34b3:	83 ec 08             	sub    $0x8,%esp
    34b6:	68 aa 61 00 00       	push   $0x61aa
    34bb:	6a 01                	push   $0x1
    34bd:	e8 ee 0d 00 00       	call   42b0 <printf>
      exit();
    34c2:	e8 6c 0c 00 00       	call   4133 <exit>
      printf(1, "chdir irefd failed\n");
    34c7:	83 ec 08             	sub    $0x8,%esp
    34ca:	68 be 61 00 00       	push   $0x61be
    34cf:	6a 01                	push   $0x1
    34d1:	e8 da 0d 00 00       	call   42b0 <printf>
      exit();
    34d6:	e8 58 0c 00 00       	call   4133 <exit>
    34db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000034e0 <forktest>:
{
    34e0:	55                   	push   %ebp
    34e1:	89 e5                	mov    %esp,%ebp
    34e3:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    34e4:	31 db                	xor    %ebx,%ebx
{
    34e6:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    34e9:	68 e6 61 00 00       	push   $0x61e6
    34ee:	6a 01                	push   $0x1
    34f0:	e8 bb 0d 00 00       	call   42b0 <printf>
    34f5:	83 c4 10             	add    $0x10,%esp
    34f8:	eb 13                	jmp    350d <forktest+0x2d>
    34fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
    3500:	74 4a                	je     354c <forktest+0x6c>
  for(n=0; n<1000; n++){
    3502:	83 c3 01             	add    $0x1,%ebx
    3505:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    350b:	74 6b                	je     3578 <forktest+0x98>
    pid = fork();
    350d:	e8 19 0c 00 00       	call   412b <fork>
    if(pid < 0)
    3512:	85 c0                	test   %eax,%eax
    3514:	79 ea                	jns    3500 <forktest+0x20>
  for(; n > 0; n--){
    3516:	85 db                	test   %ebx,%ebx
    3518:	74 14                	je     352e <forktest+0x4e>
    351a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    3520:	e8 16 0c 00 00       	call   413b <wait>
    3525:	85 c0                	test   %eax,%eax
    3527:	78 28                	js     3551 <forktest+0x71>
  for(; n > 0; n--){
    3529:	83 eb 01             	sub    $0x1,%ebx
    352c:	75 f2                	jne    3520 <forktest+0x40>
  if(wait() != -1){
    352e:	e8 08 0c 00 00       	call   413b <wait>
    3533:	83 f8 ff             	cmp    $0xffffffff,%eax
    3536:	75 2d                	jne    3565 <forktest+0x85>
  printf(1, "fork test OK\n");
    3538:	83 ec 08             	sub    $0x8,%esp
    353b:	68 18 62 00 00       	push   $0x6218
    3540:	6a 01                	push   $0x1
    3542:	e8 69 0d 00 00       	call   42b0 <printf>
}
    3547:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    354a:	c9                   	leave
    354b:	c3                   	ret
      exit();
    354c:	e8 e2 0b 00 00       	call   4133 <exit>
      printf(1, "wait stopped early\n");
    3551:	83 ec 08             	sub    $0x8,%esp
    3554:	68 f1 61 00 00       	push   $0x61f1
    3559:	6a 01                	push   $0x1
    355b:	e8 50 0d 00 00       	call   42b0 <printf>
      exit();
    3560:	e8 ce 0b 00 00       	call   4133 <exit>
    printf(1, "wait got too many\n");
    3565:	52                   	push   %edx
    3566:	52                   	push   %edx
    3567:	68 05 62 00 00       	push   $0x6205
    356c:	6a 01                	push   $0x1
    356e:	e8 3d 0d 00 00       	call   42b0 <printf>
    exit();
    3573:	e8 bb 0b 00 00       	call   4133 <exit>
    printf(1, "fork claimed to work 1000 times!\n");
    3578:	50                   	push   %eax
    3579:	50                   	push   %eax
    357a:	68 f8 50 00 00       	push   $0x50f8
    357f:	6a 01                	push   $0x1
    3581:	e8 2a 0d 00 00       	call   42b0 <printf>
    exit();
    3586:	e8 a8 0b 00 00       	call   4133 <exit>
    358b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00003590 <sbrktest>:
{
    3590:	55                   	push   %ebp
    3591:	89 e5                	mov    %esp,%ebp
    3593:	57                   	push   %edi
    3594:	56                   	push   %esi
  for(i = 0; i < 5000; i++){
    3595:	31 f6                	xor    %esi,%esi
{
    3597:	53                   	push   %ebx
    3598:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    359b:	68 26 62 00 00       	push   $0x6226
    35a0:	ff 35 78 6e 00 00    	push   0x6e78
    35a6:	e8 05 0d 00 00       	call   42b0 <printf>
  oldbrk = sbrk(0);
    35ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35b2:	e8 04 0c 00 00       	call   41bb <sbrk>
    35b7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  a = sbrk(0);
    35ba:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    35c1:	e8 f5 0b 00 00       	call   41bb <sbrk>
    35c6:	83 c4 10             	add    $0x10,%esp
    35c9:	89 c3                	mov    %eax,%ebx
  for(i = 0; i < 5000; i++){
    35cb:	eb 05                	jmp    35d2 <sbrktest+0x42>
    35cd:	8d 76 00             	lea    0x0(%esi),%esi
    35d0:	89 c3                	mov    %eax,%ebx
    b = sbrk(1);
    35d2:	83 ec 0c             	sub    $0xc,%esp
    35d5:	6a 01                	push   $0x1
    35d7:	e8 df 0b 00 00       	call   41bb <sbrk>
    if(b != a){
    35dc:	83 c4 10             	add    $0x10,%esp
    35df:	39 d8                	cmp    %ebx,%eax
    35e1:	0f 85 9c 02 00 00    	jne    3883 <sbrktest+0x2f3>
  for(i = 0; i < 5000; i++){
    35e7:	83 c6 01             	add    $0x1,%esi
    *b = 1;
    35ea:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    35ed:	8d 43 01             	lea    0x1(%ebx),%eax
  for(i = 0; i < 5000; i++){
    35f0:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    35f6:	75 d8                	jne    35d0 <sbrktest+0x40>
  pid = fork();
    35f8:	e8 2e 0b 00 00       	call   412b <fork>
    35fd:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    35ff:	85 c0                	test   %eax,%eax
    3601:	0f 88 02 03 00 00    	js     3909 <sbrktest+0x379>
  c = sbrk(1);
    3607:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    360a:	83 c3 02             	add    $0x2,%ebx
  c = sbrk(1);
    360d:	6a 01                	push   $0x1
    360f:	e8 a7 0b 00 00       	call   41bb <sbrk>
  c = sbrk(1);
    3614:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    361b:	e8 9b 0b 00 00       	call   41bb <sbrk>
  if(c != a + 1){
    3620:	83 c4 10             	add    $0x10,%esp
    3623:	39 c3                	cmp    %eax,%ebx
    3625:	0f 85 3b 03 00 00    	jne    3966 <sbrktest+0x3d6>
  if(pid == 0)
    362b:	85 f6                	test   %esi,%esi
    362d:	0f 84 2e 03 00 00    	je     3961 <sbrktest+0x3d1>
  wait();
    3633:	e8 03 0b 00 00       	call   413b <wait>
  a = sbrk(0);
    3638:	83 ec 0c             	sub    $0xc,%esp
    363b:	6a 00                	push   $0x0
    363d:	e8 79 0b 00 00       	call   41bb <sbrk>
    3642:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    3644:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3649:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    364b:	89 04 24             	mov    %eax,(%esp)
    364e:	e8 68 0b 00 00       	call   41bb <sbrk>
  if (p != a) {
    3653:	83 c4 10             	add    $0x10,%esp
    3656:	39 c3                	cmp    %eax,%ebx
    3658:	0f 85 94 02 00 00    	jne    38f2 <sbrktest+0x362>
  a = sbrk(0);
    365e:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    3661:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    3668:	6a 00                	push   $0x0
    366a:	e8 4c 0b 00 00       	call   41bb <sbrk>
  c = sbrk(-4096);
    366f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    3676:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    3678:	e8 3e 0b 00 00       	call   41bb <sbrk>
  if(c == (char*)0xffffffff){
    367d:	83 c4 10             	add    $0x10,%esp
    3680:	83 f8 ff             	cmp    $0xffffffff,%eax
    3683:	0f 84 22 03 00 00    	je     39ab <sbrktest+0x41b>
  c = sbrk(0);
    3689:	83 ec 0c             	sub    $0xc,%esp
    368c:	6a 00                	push   $0x0
    368e:	e8 28 0b 00 00       	call   41bb <sbrk>
  if(c != a - 4096){
    3693:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    3699:	83 c4 10             	add    $0x10,%esp
    369c:	39 d0                	cmp    %edx,%eax
    369e:	0f 85 f0 02 00 00    	jne    3994 <sbrktest+0x404>
  a = sbrk(0);
    36a4:	83 ec 0c             	sub    $0xc,%esp
    36a7:	6a 00                	push   $0x0
    36a9:	e8 0d 0b 00 00       	call   41bb <sbrk>
  c = sbrk(4096);
    36ae:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    36b5:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    36b7:	e8 ff 0a 00 00       	call   41bb <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    36bc:	83 c4 10             	add    $0x10,%esp
  c = sbrk(4096);
    36bf:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    36c1:	39 c3                	cmp    %eax,%ebx
    36c3:	0f 85 b4 02 00 00    	jne    397d <sbrktest+0x3ed>
    36c9:	83 ec 0c             	sub    $0xc,%esp
    36cc:	6a 00                	push   $0x0
    36ce:	e8 e8 0a 00 00       	call   41bb <sbrk>
    36d3:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    36d9:	83 c4 10             	add    $0x10,%esp
    36dc:	39 c2                	cmp    %eax,%edx
    36de:	0f 85 99 02 00 00    	jne    397d <sbrktest+0x3ed>
  if(*lastaddr == 99){
    36e4:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    36eb:	0f 84 2f 02 00 00    	je     3920 <sbrktest+0x390>
  a = sbrk(0);
    36f1:	83 ec 0c             	sub    $0xc,%esp
    36f4:	6a 00                	push   $0x0
    36f6:	e8 c0 0a 00 00       	call   41bb <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    36fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    3702:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    3704:	e8 b2 0a 00 00       	call   41bb <sbrk>
    3709:	89 c2                	mov    %eax,%edx
    370b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    370e:	29 d0                	sub    %edx,%eax
    3710:	89 04 24             	mov    %eax,(%esp)
    3713:	e8 a3 0a 00 00       	call   41bb <sbrk>
  if(c != a){
    3718:	83 c4 10             	add    $0x10,%esp
    371b:	39 c3                	cmp    %eax,%ebx
    371d:	0f 85 b8 01 00 00    	jne    38db <sbrktest+0x34b>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3723:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    3728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    372f:	00 
    ppid = getpid();
    3730:	e8 7e 0a 00 00       	call   41b3 <getpid>
    3735:	89 c6                	mov    %eax,%esi
    pid = fork();
    3737:	e8 ef 09 00 00       	call   412b <fork>
    if(pid < 0){
    373c:	85 c0                	test   %eax,%eax
    373e:	0f 88 5d 01 00 00    	js     38a1 <sbrktest+0x311>
    if(pid == 0){
    3744:	0f 84 6f 01 00 00    	je     38b9 <sbrktest+0x329>
    wait();
    374a:	e8 ec 09 00 00       	call   413b <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    374f:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    3755:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    375b:	75 d3                	jne    3730 <sbrktest+0x1a0>
  if(pipe(fds) != 0){
    375d:	83 ec 0c             	sub    $0xc,%esp
    3760:	8d 45 b8             	lea    -0x48(%ebp),%eax
    3763:	50                   	push   %eax
    3764:	e8 da 09 00 00       	call   4143 <pipe>
    3769:	83 c4 10             	add    $0x10,%esp
    376c:	85 c0                	test   %eax,%eax
    376e:	0f 85 da 01 00 00    	jne    394e <sbrktest+0x3be>
    3774:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    3777:	8d 75 e8             	lea    -0x18(%ebp),%esi
    377a:	89 df                	mov    %ebx,%edi
    377c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((pids[i] = fork()) == 0){
    3780:	e8 a6 09 00 00       	call   412b <fork>
    3785:	89 07                	mov    %eax,(%edi)
    3787:	85 c0                	test   %eax,%eax
    3789:	0f 84 91 00 00 00    	je     3820 <sbrktest+0x290>
    if(pids[i] != -1)
    378f:	83 f8 ff             	cmp    $0xffffffff,%eax
    3792:	74 14                	je     37a8 <sbrktest+0x218>
      read(fds[0], &scratch, 1);
    3794:	83 ec 04             	sub    $0x4,%esp
    3797:	8d 45 b7             	lea    -0x49(%ebp),%eax
    379a:	6a 01                	push   $0x1
    379c:	50                   	push   %eax
    379d:	ff 75 b8             	push   -0x48(%ebp)
    37a0:	e8 a6 09 00 00       	call   414b <read>
    37a5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    37a8:	83 c7 04             	add    $0x4,%edi
    37ab:	39 f7                	cmp    %esi,%edi
    37ad:	75 d1                	jne    3780 <sbrktest+0x1f0>
  c = sbrk(4096);
    37af:	83 ec 0c             	sub    $0xc,%esp
    37b2:	68 00 10 00 00       	push   $0x1000
    37b7:	e8 ff 09 00 00       	call   41bb <sbrk>
    37bc:	83 c4 10             	add    $0x10,%esp
    37bf:	89 c7                	mov    %eax,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    37c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pids[i] == -1)
    37c8:	8b 03                	mov    (%ebx),%eax
    37ca:	83 f8 ff             	cmp    $0xffffffff,%eax
    37cd:	74 11                	je     37e0 <sbrktest+0x250>
    kill(pids[i]);
    37cf:	83 ec 0c             	sub    $0xc,%esp
    37d2:	50                   	push   %eax
    37d3:	e8 8b 09 00 00       	call   4163 <kill>
    wait();
    37d8:	e8 5e 09 00 00       	call   413b <wait>
    37dd:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    37e0:	83 c3 04             	add    $0x4,%ebx
    37e3:	39 f3                	cmp    %esi,%ebx
    37e5:	75 e1                	jne    37c8 <sbrktest+0x238>
  if(c == (char*)0xffffffff){
    37e7:	83 ff ff             	cmp    $0xffffffff,%edi
    37ea:	0f 84 47 01 00 00    	je     3937 <sbrktest+0x3a7>
  if(sbrk(0) > oldbrk)
    37f0:	83 ec 0c             	sub    $0xc,%esp
    37f3:	6a 00                	push   $0x0
    37f5:	e8 c1 09 00 00       	call   41bb <sbrk>
    37fa:	83 c4 10             	add    $0x10,%esp
    37fd:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    3800:	72 60                	jb     3862 <sbrktest+0x2d2>
  printf(stdout, "sbrk test OK\n");
    3802:	83 ec 08             	sub    $0x8,%esp
    3805:	68 ce 62 00 00       	push   $0x62ce
    380a:	ff 35 78 6e 00 00    	push   0x6e78
    3810:	e8 9b 0a 00 00       	call   42b0 <printf>
}
    3815:	83 c4 10             	add    $0x10,%esp
    3818:	8d 65 f4             	lea    -0xc(%ebp),%esp
    381b:	5b                   	pop    %ebx
    381c:	5e                   	pop    %esi
    381d:	5f                   	pop    %edi
    381e:	5d                   	pop    %ebp
    381f:	c3                   	ret
      sbrk(BIG - (uint)sbrk(0));
    3820:	83 ec 0c             	sub    $0xc,%esp
    3823:	6a 00                	push   $0x0
    3825:	e8 91 09 00 00       	call   41bb <sbrk>
    382a:	89 c2                	mov    %eax,%edx
    382c:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3831:	29 d0                	sub    %edx,%eax
    3833:	89 04 24             	mov    %eax,(%esp)
    3836:	e8 80 09 00 00       	call   41bb <sbrk>
      write(fds[1], "x", 1);
    383b:	83 c4 0c             	add    $0xc,%esp
    383e:	6a 01                	push   $0x1
    3840:	68 8f 5d 00 00       	push   $0x5d8f
    3845:	ff 75 bc             	push   -0x44(%ebp)
    3848:	e8 06 09 00 00       	call   4153 <write>
    384d:	83 c4 10             	add    $0x10,%esp
      for(;;) sleep(1000);
    3850:	83 ec 0c             	sub    $0xc,%esp
    3853:	68 e8 03 00 00       	push   $0x3e8
    3858:	e8 66 09 00 00       	call   41c3 <sleep>
    385d:	83 c4 10             	add    $0x10,%esp
    3860:	eb ee                	jmp    3850 <sbrktest+0x2c0>
    sbrk(-(sbrk(0) - oldbrk));
    3862:	83 ec 0c             	sub    $0xc,%esp
    3865:	6a 00                	push   $0x0
    3867:	e8 4f 09 00 00       	call   41bb <sbrk>
    386c:	89 c2                	mov    %eax,%edx
    386e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3871:	29 d0                	sub    %edx,%eax
    3873:	89 04 24             	mov    %eax,(%esp)
    3876:	e8 40 09 00 00       	call   41bb <sbrk>
    387b:	83 c4 10             	add    $0x10,%esp
    387e:	e9 7f ff ff ff       	jmp    3802 <sbrktest+0x272>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3883:	83 ec 0c             	sub    $0xc,%esp
    3886:	50                   	push   %eax
    3887:	53                   	push   %ebx
    3888:	56                   	push   %esi
    3889:	68 31 62 00 00       	push   $0x6231
    388e:	ff 35 78 6e 00 00    	push   0x6e78
    3894:	e8 17 0a 00 00       	call   42b0 <printf>
      exit();
    3899:	83 c4 20             	add    $0x20,%esp
    389c:	e8 92 08 00 00       	call   4133 <exit>
      printf(stdout, "fork failed\n");
    38a1:	83 ec 08             	sub    $0x8,%esp
    38a4:	68 77 63 00 00       	push   $0x6377
    38a9:	ff 35 78 6e 00 00    	push   0x6e78
    38af:	e8 fc 09 00 00       	call   42b0 <printf>
      exit();
    38b4:	e8 7a 08 00 00       	call   4133 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    38b9:	0f be 03             	movsbl (%ebx),%eax
    38bc:	50                   	push   %eax
    38bd:	53                   	push   %ebx
    38be:	68 9a 62 00 00       	push   $0x629a
    38c3:	ff 35 78 6e 00 00    	push   0x6e78
    38c9:	e8 e2 09 00 00       	call   42b0 <printf>
      kill(ppid);
    38ce:	89 34 24             	mov    %esi,(%esp)
    38d1:	e8 8d 08 00 00       	call   4163 <kill>
      exit();
    38d6:	e8 58 08 00 00       	call   4133 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    38db:	50                   	push   %eax
    38dc:	53                   	push   %ebx
    38dd:	68 ec 51 00 00       	push   $0x51ec
    38e2:	ff 35 78 6e 00 00    	push   0x6e78
    38e8:	e8 c3 09 00 00       	call   42b0 <printf>
    exit();
    38ed:	e8 41 08 00 00       	call   4133 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    38f2:	56                   	push   %esi
    38f3:	56                   	push   %esi
    38f4:	68 1c 51 00 00       	push   $0x511c
    38f9:	ff 35 78 6e 00 00    	push   0x6e78
    38ff:	e8 ac 09 00 00       	call   42b0 <printf>
    exit();
    3904:	e8 2a 08 00 00       	call   4133 <exit>
    printf(stdout, "sbrk test fork failed\n");
    3909:	50                   	push   %eax
    390a:	50                   	push   %eax
    390b:	68 4c 62 00 00       	push   $0x624c
    3910:	ff 35 78 6e 00 00    	push   0x6e78
    3916:	e8 95 09 00 00       	call   42b0 <printf>
    exit();
    391b:	e8 13 08 00 00       	call   4133 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3920:	51                   	push   %ecx
    3921:	51                   	push   %ecx
    3922:	68 bc 51 00 00       	push   $0x51bc
    3927:	ff 35 78 6e 00 00    	push   0x6e78
    392d:	e8 7e 09 00 00       	call   42b0 <printf>
    exit();
    3932:	e8 fc 07 00 00       	call   4133 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    3937:	50                   	push   %eax
    3938:	50                   	push   %eax
    3939:	68 b3 62 00 00       	push   $0x62b3
    393e:	ff 35 78 6e 00 00    	push   0x6e78
    3944:	e8 67 09 00 00       	call   42b0 <printf>
    exit();
    3949:	e8 e5 07 00 00       	call   4133 <exit>
    printf(1, "pipe() failed\n");
    394e:	52                   	push   %edx
    394f:	52                   	push   %edx
    3950:	68 6f 57 00 00       	push   $0x576f
    3955:	6a 01                	push   $0x1
    3957:	e8 54 09 00 00       	call   42b0 <printf>
    exit();
    395c:	e8 d2 07 00 00       	call   4133 <exit>
    exit();
    3961:	e8 cd 07 00 00       	call   4133 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    3966:	57                   	push   %edi
    3967:	57                   	push   %edi
    3968:	68 63 62 00 00       	push   $0x6263
    396d:	ff 35 78 6e 00 00    	push   0x6e78
    3973:	e8 38 09 00 00       	call   42b0 <printf>
    exit();
    3978:	e8 b6 07 00 00       	call   4133 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    397d:	56                   	push   %esi
    397e:	53                   	push   %ebx
    397f:	68 94 51 00 00       	push   $0x5194
    3984:	ff 35 78 6e 00 00    	push   0x6e78
    398a:	e8 21 09 00 00       	call   42b0 <printf>
    exit();
    398f:	e8 9f 07 00 00       	call   4133 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3994:	50                   	push   %eax
    3995:	53                   	push   %ebx
    3996:	68 5c 51 00 00       	push   $0x515c
    399b:	ff 35 78 6e 00 00    	push   0x6e78
    39a1:	e8 0a 09 00 00       	call   42b0 <printf>
    exit();
    39a6:	e8 88 07 00 00       	call   4133 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    39ab:	53                   	push   %ebx
    39ac:	53                   	push   %ebx
    39ad:	68 7f 62 00 00       	push   $0x627f
    39b2:	ff 35 78 6e 00 00    	push   0x6e78
    39b8:	e8 f3 08 00 00       	call   42b0 <printf>
    exit();
    39bd:	e8 71 07 00 00       	call   4133 <exit>
    39c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    39c9:	00 
    39ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000039d0 <validateint>:
}
    39d0:	c3                   	ret
    39d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    39d8:	00 
    39d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000039e0 <validatetest>:
{
    39e0:	55                   	push   %ebp
    39e1:	89 e5                	mov    %esp,%ebp
    39e3:	56                   	push   %esi
  for(p = 0; p <= (uint)hi; p += 4096){
    39e4:	31 f6                	xor    %esi,%esi
{
    39e6:	53                   	push   %ebx
  printf(stdout, "validate test\n");
    39e7:	83 ec 08             	sub    $0x8,%esp
    39ea:	68 dc 62 00 00       	push   $0x62dc
    39ef:	ff 35 78 6e 00 00    	push   0x6e78
    39f5:	e8 b6 08 00 00       	call   42b0 <printf>
    39fa:	83 c4 10             	add    $0x10,%esp
    39fd:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    3a00:	e8 26 07 00 00       	call   412b <fork>
    3a05:	89 c3                	mov    %eax,%ebx
    3a07:	85 c0                	test   %eax,%eax
    3a09:	74 63                	je     3a6e <validatetest+0x8e>
    sleep(0);
    3a0b:	83 ec 0c             	sub    $0xc,%esp
    3a0e:	6a 00                	push   $0x0
    3a10:	e8 ae 07 00 00       	call   41c3 <sleep>
    sleep(0);
    3a15:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3a1c:	e8 a2 07 00 00       	call   41c3 <sleep>
    kill(pid);
    3a21:	89 1c 24             	mov    %ebx,(%esp)
    3a24:	e8 3a 07 00 00       	call   4163 <kill>
    wait();
    3a29:	e8 0d 07 00 00       	call   413b <wait>
    if(link("nosuchfile", (char*)p) != -1){
    3a2e:	58                   	pop    %eax
    3a2f:	5a                   	pop    %edx
    3a30:	56                   	push   %esi
    3a31:	68 eb 62 00 00       	push   $0x62eb
    3a36:	e8 58 07 00 00       	call   4193 <link>
    3a3b:	83 c4 10             	add    $0x10,%esp
    3a3e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3a41:	75 30                	jne    3a73 <validatetest+0x93>
  for(p = 0; p <= (uint)hi; p += 4096){
    3a43:	81 c6 00 10 00 00    	add    $0x1000,%esi
    3a49:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    3a4f:	75 af                	jne    3a00 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    3a51:	83 ec 08             	sub    $0x8,%esp
    3a54:	68 0f 63 00 00       	push   $0x630f
    3a59:	ff 35 78 6e 00 00    	push   0x6e78
    3a5f:	e8 4c 08 00 00       	call   42b0 <printf>
}
    3a64:	83 c4 10             	add    $0x10,%esp
    3a67:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3a6a:	5b                   	pop    %ebx
    3a6b:	5e                   	pop    %esi
    3a6c:	5d                   	pop    %ebp
    3a6d:	c3                   	ret
      exit();
    3a6e:	e8 c0 06 00 00       	call   4133 <exit>
      printf(stdout, "link should not succeed\n");
    3a73:	83 ec 08             	sub    $0x8,%esp
    3a76:	68 f6 62 00 00       	push   $0x62f6
    3a7b:	ff 35 78 6e 00 00    	push   0x6e78
    3a81:	e8 2a 08 00 00       	call   42b0 <printf>
      exit();
    3a86:	e8 a8 06 00 00       	call   4133 <exit>
    3a8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00003a90 <bsstest>:
{
    3a90:	55                   	push   %ebp
    3a91:	89 e5                	mov    %esp,%ebp
    3a93:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    3a96:	68 1c 63 00 00       	push   $0x631c
    3a9b:	ff 35 78 6e 00 00    	push   0x6e78
    3aa1:	e8 0a 08 00 00       	call   42b0 <printf>
    3aa6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3aa9:	31 c0                	xor    %eax,%eax
    3aab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(uninit[i] != '\0'){
    3ab0:	80 b8 a0 6e 00 00 00 	cmpb   $0x0,0x6ea0(%eax)
    3ab7:	75 22                	jne    3adb <bsstest+0x4b>
  for(i = 0; i < sizeof(uninit); i++){
    3ab9:	83 c0 01             	add    $0x1,%eax
    3abc:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3ac1:	75 ed                	jne    3ab0 <bsstest+0x20>
  printf(stdout, "bss test ok\n");
    3ac3:	83 ec 08             	sub    $0x8,%esp
    3ac6:	68 37 63 00 00       	push   $0x6337
    3acb:	ff 35 78 6e 00 00    	push   0x6e78
    3ad1:	e8 da 07 00 00       	call   42b0 <printf>
}
    3ad6:	83 c4 10             	add    $0x10,%esp
    3ad9:	c9                   	leave
    3ada:	c3                   	ret
      printf(stdout, "bss test failed\n");
    3adb:	83 ec 08             	sub    $0x8,%esp
    3ade:	68 26 63 00 00       	push   $0x6326
    3ae3:	ff 35 78 6e 00 00    	push   0x6e78
    3ae9:	e8 c2 07 00 00       	call   42b0 <printf>
      exit();
    3aee:	e8 40 06 00 00       	call   4133 <exit>
    3af3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3afa:	00 
    3afb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00003b00 <bigargtest>:
{
    3b00:	55                   	push   %ebp
    3b01:	89 e5                	mov    %esp,%ebp
    3b03:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    3b06:	68 44 63 00 00       	push   $0x6344
    3b0b:	e8 73 06 00 00       	call   4183 <unlink>
  pid = fork();
    3b10:	e8 16 06 00 00       	call   412b <fork>
  if(pid == 0){
    3b15:	83 c4 10             	add    $0x10,%esp
    3b18:	85 c0                	test   %eax,%eax
    3b1a:	74 3f                	je     3b5b <bigargtest+0x5b>
  } else if(pid < 0){
    3b1c:	0f 88 d9 00 00 00    	js     3bfb <bigargtest+0xfb>
  wait();
    3b22:	e8 14 06 00 00       	call   413b <wait>
  fd = open("bigarg-ok", 0);
    3b27:	83 ec 08             	sub    $0x8,%esp
    3b2a:	6a 00                	push   $0x0
    3b2c:	68 44 63 00 00       	push   $0x6344
    3b31:	e8 3d 06 00 00       	call   4173 <open>
  if(fd < 0){
    3b36:	83 c4 10             	add    $0x10,%esp
    3b39:	85 c0                	test   %eax,%eax
    3b3b:	0f 88 a3 00 00 00    	js     3be4 <bigargtest+0xe4>
  close(fd);
    3b41:	83 ec 0c             	sub    $0xc,%esp
    3b44:	50                   	push   %eax
    3b45:	e8 11 06 00 00       	call   415b <close>
  unlink("bigarg-ok");
    3b4a:	c7 04 24 44 63 00 00 	movl   $0x6344,(%esp)
    3b51:	e8 2d 06 00 00       	call   4183 <unlink>
}
    3b56:	83 c4 10             	add    $0x10,%esp
    3b59:	c9                   	leave
    3b5a:	c3                   	ret
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3b5b:	c7 04 85 c0 b5 00 00 	movl   $0x5210,0xb5c0(,%eax,4)
    3b62:	10 52 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3b66:	b8 01 00 00 00       	mov    $0x1,%eax
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3b6b:	c7 04 85 c0 b5 00 00 	movl   $0x5210,0xb5c0(,%eax,4)
    3b72:	10 52 00 00 
    3b76:	c7 04 85 c4 b5 00 00 	movl   $0x5210,0xb5c4(,%eax,4)
    3b7d:	10 52 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3b81:	83 c0 02             	add    $0x2,%eax
    3b84:	83 f8 1f             	cmp    $0x1f,%eax
    3b87:	75 e2                	jne    3b6b <bigargtest+0x6b>
    printf(stdout, "bigarg test\n");
    3b89:	50                   	push   %eax
    args[MAXARG-1] = 0;
    3b8a:	31 c9                	xor    %ecx,%ecx
    printf(stdout, "bigarg test\n");
    3b8c:	50                   	push   %eax
    3b8d:	68 4e 63 00 00       	push   $0x634e
    3b92:	ff 35 78 6e 00 00    	push   0x6e78
    args[MAXARG-1] = 0;
    3b98:	89 0d 3c b6 00 00    	mov    %ecx,0xb63c
    printf(stdout, "bigarg test\n");
    3b9e:	e8 0d 07 00 00       	call   42b0 <printf>
    exec("echo", args);
    3ba3:	58                   	pop    %eax
    3ba4:	5a                   	pop    %edx
    3ba5:	68 c0 b5 00 00       	push   $0xb5c0
    3baa:	68 1b 55 00 00       	push   $0x551b
    3baf:	e8 b7 05 00 00       	call   416b <exec>
    printf(stdout, "bigarg test ok\n");
    3bb4:	59                   	pop    %ecx
    3bb5:	58                   	pop    %eax
    3bb6:	68 5b 63 00 00       	push   $0x635b
    3bbb:	ff 35 78 6e 00 00    	push   0x6e78
    3bc1:	e8 ea 06 00 00       	call   42b0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3bc6:	58                   	pop    %eax
    3bc7:	5a                   	pop    %edx
    3bc8:	68 00 02 00 00       	push   $0x200
    3bcd:	68 44 63 00 00       	push   $0x6344
    3bd2:	e8 9c 05 00 00       	call   4173 <open>
    close(fd);
    3bd7:	89 04 24             	mov    %eax,(%esp)
    3bda:	e8 7c 05 00 00       	call   415b <close>
    exit();
    3bdf:	e8 4f 05 00 00       	call   4133 <exit>
    printf(stdout, "bigarg test failed!\n");
    3be4:	50                   	push   %eax
    3be5:	50                   	push   %eax
    3be6:	68 84 63 00 00       	push   $0x6384
    3beb:	ff 35 78 6e 00 00    	push   0x6e78
    3bf1:	e8 ba 06 00 00       	call   42b0 <printf>
    exit();
    3bf6:	e8 38 05 00 00       	call   4133 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3bfb:	52                   	push   %edx
    3bfc:	52                   	push   %edx
    3bfd:	68 6b 63 00 00       	push   $0x636b
    3c02:	ff 35 78 6e 00 00    	push   0x6e78
    3c08:	e8 a3 06 00 00       	call   42b0 <printf>
    exit();
    3c0d:	e8 21 05 00 00       	call   4133 <exit>
    3c12:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3c19:	00 
    3c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003c20 <fsfull>:
{
    3c20:	55                   	push   %ebp
    3c21:	89 e5                	mov    %esp,%ebp
    3c23:	57                   	push   %edi
    3c24:	56                   	push   %esi
  for(nfiles = 0; ; nfiles++){
    3c25:	31 f6                	xor    %esi,%esi
{
    3c27:	53                   	push   %ebx
    3c28:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    3c2b:	68 99 63 00 00       	push   $0x6399
    3c30:	6a 01                	push   $0x1
    3c32:	e8 79 06 00 00       	call   42b0 <printf>
    3c37:	83 c4 10             	add    $0x10,%esp
    3c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    3c40:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3c45:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    3c4a:	83 ec 04             	sub    $0x4,%esp
    name[0] = 'f';
    3c4d:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3c51:	f7 e6                	mul    %esi
    name[5] = '\0';
    3c53:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3c57:	c1 ea 06             	shr    $0x6,%edx
    3c5a:	8d 42 30             	lea    0x30(%edx),%eax
    3c5d:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3c60:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    3c66:	89 f2                	mov    %esi,%edx
    3c68:	29 c2                	sub    %eax,%edx
    3c6a:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3c6f:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    3c71:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3c76:	c1 ea 05             	shr    $0x5,%edx
    3c79:	83 c2 30             	add    $0x30,%edx
    3c7c:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3c7f:	f7 e6                	mul    %esi
    3c81:	c1 ea 05             	shr    $0x5,%edx
    3c84:	6b c2 64             	imul   $0x64,%edx,%eax
    3c87:	89 f2                	mov    %esi,%edx
    3c89:	29 c2                	sub    %eax,%edx
    3c8b:	89 d0                	mov    %edx,%eax
    3c8d:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3c8f:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3c91:	c1 ea 03             	shr    $0x3,%edx
    3c94:	83 c2 30             	add    $0x30,%edx
    3c97:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3c9a:	f7 e1                	mul    %ecx
    3c9c:	89 f0                	mov    %esi,%eax
    3c9e:	c1 ea 03             	shr    $0x3,%edx
    3ca1:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3ca4:	01 d2                	add    %edx,%edx
    3ca6:	29 d0                	sub    %edx,%eax
    3ca8:	83 c0 30             	add    $0x30,%eax
    3cab:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    3cae:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3cb1:	50                   	push   %eax
    3cb2:	68 a6 63 00 00       	push   $0x63a6
    3cb7:	6a 01                	push   $0x1
    3cb9:	e8 f2 05 00 00       	call   42b0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3cbe:	58                   	pop    %eax
    3cbf:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3cc2:	5a                   	pop    %edx
    3cc3:	68 02 02 00 00       	push   $0x202
    3cc8:	50                   	push   %eax
    3cc9:	e8 a5 04 00 00       	call   4173 <open>
    if(fd < 0){
    3cce:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3cd1:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3cd3:	85 c0                	test   %eax,%eax
    3cd5:	78 4f                	js     3d26 <fsfull+0x106>
    int total = 0;
    3cd7:	31 db                	xor    %ebx,%ebx
    3cd9:	eb 07                	jmp    3ce2 <fsfull+0xc2>
    3cdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      total += cc;
    3ce0:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
    3ce2:	83 ec 04             	sub    $0x4,%esp
    3ce5:	68 00 02 00 00       	push   $0x200
    3cea:	68 c0 95 00 00       	push   $0x95c0
    3cef:	57                   	push   %edi
    3cf0:	e8 5e 04 00 00       	call   4153 <write>
      if(cc < 512)
    3cf5:	83 c4 10             	add    $0x10,%esp
    3cf8:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3cfd:	7f e1                	jg     3ce0 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    3cff:	83 ec 04             	sub    $0x4,%esp
    3d02:	53                   	push   %ebx
    3d03:	68 c2 63 00 00       	push   $0x63c2
    3d08:	6a 01                	push   $0x1
    3d0a:	e8 a1 05 00 00       	call   42b0 <printf>
    close(fd);
    3d0f:	89 3c 24             	mov    %edi,(%esp)
    3d12:	e8 44 04 00 00       	call   415b <close>
    if(total == 0)
    3d17:	83 c4 10             	add    $0x10,%esp
    3d1a:	85 db                	test   %ebx,%ebx
    3d1c:	74 1e                	je     3d3c <fsfull+0x11c>
  for(nfiles = 0; ; nfiles++){
    3d1e:	83 c6 01             	add    $0x1,%esi
    3d21:	e9 1a ff ff ff       	jmp    3c40 <fsfull+0x20>
      printf(1, "open %s failed\n", name);
    3d26:	83 ec 04             	sub    $0x4,%esp
    3d29:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3d2c:	50                   	push   %eax
    3d2d:	68 b2 63 00 00       	push   $0x63b2
    3d32:	6a 01                	push   $0x1
    3d34:	e8 77 05 00 00       	call   42b0 <printf>
      break;
    3d39:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    3d3c:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    3d41:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    3d46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3d4d:	00 
    3d4e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + nfiles / 1000;
    3d50:	89 f0                	mov    %esi,%eax
    unlink(name);
    3d52:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'f';
    3d55:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3d59:	f7 e7                	mul    %edi
    name[5] = '\0';
    3d5b:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3d5f:	c1 ea 06             	shr    $0x6,%edx
    3d62:	8d 42 30             	lea    0x30(%edx),%eax
    3d65:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3d68:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    3d6e:	89 f2                	mov    %esi,%edx
    3d70:	29 c2                	sub    %eax,%edx
    3d72:	89 d0                	mov    %edx,%eax
    3d74:	f7 e3                	mul    %ebx
    name[3] = '0' + (nfiles % 100) / 10;
    3d76:	89 f0                	mov    %esi,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3d78:	c1 ea 05             	shr    $0x5,%edx
    3d7b:	83 c2 30             	add    $0x30,%edx
    3d7e:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3d81:	f7 e3                	mul    %ebx
    3d83:	c1 ea 05             	shr    $0x5,%edx
    3d86:	6b ca 64             	imul   $0x64,%edx,%ecx
    3d89:	89 f2                	mov    %esi,%edx
    3d8b:	29 ca                	sub    %ecx,%edx
    3d8d:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    3d92:	89 d0                	mov    %edx,%eax
    3d94:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3d96:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3d98:	c1 ea 03             	shr    $0x3,%edx
    3d9b:	83 c2 30             	add    $0x30,%edx
    3d9e:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3da1:	f7 e1                	mul    %ecx
    3da3:	89 f0                	mov    %esi,%eax
    nfiles--;
    3da5:	83 ee 01             	sub    $0x1,%esi
    name[4] = '0' + (nfiles % 10);
    3da8:	c1 ea 03             	shr    $0x3,%edx
    3dab:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3dae:	01 d2                	add    %edx,%edx
    3db0:	29 d0                	sub    %edx,%eax
    3db2:	83 c0 30             	add    $0x30,%eax
    3db5:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3db8:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3dbb:	50                   	push   %eax
    3dbc:	e8 c2 03 00 00       	call   4183 <unlink>
  while(nfiles >= 0){
    3dc1:	83 c4 10             	add    $0x10,%esp
    3dc4:	83 fe ff             	cmp    $0xffffffff,%esi
    3dc7:	75 87                	jne    3d50 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    3dc9:	83 ec 08             	sub    $0x8,%esp
    3dcc:	68 d2 63 00 00       	push   $0x63d2
    3dd1:	6a 01                	push   $0x1
    3dd3:	e8 d8 04 00 00       	call   42b0 <printf>
}
    3dd8:	83 c4 10             	add    $0x10,%esp
    3ddb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3dde:	5b                   	pop    %ebx
    3ddf:	5e                   	pop    %esi
    3de0:	5f                   	pop    %edi
    3de1:	5d                   	pop    %ebp
    3de2:	c3                   	ret
    3de3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3dea:	00 
    3deb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00003df0 <uio>:
{
    3df0:	55                   	push   %ebp
    3df1:	89 e5                	mov    %esp,%ebp
    3df3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    3df6:	68 e8 63 00 00       	push   $0x63e8
    3dfb:	6a 01                	push   $0x1
    3dfd:	e8 ae 04 00 00       	call   42b0 <printf>
  pid = fork();
    3e02:	e8 24 03 00 00       	call   412b <fork>
  if(pid == 0){
    3e07:	83 c4 10             	add    $0x10,%esp
    3e0a:	85 c0                	test   %eax,%eax
    3e0c:	74 1b                	je     3e29 <uio+0x39>
  } else if(pid < 0){
    3e0e:	78 3d                	js     3e4d <uio+0x5d>
  wait();
    3e10:	e8 26 03 00 00       	call   413b <wait>
  printf(1, "uio test done\n");
    3e15:	83 ec 08             	sub    $0x8,%esp
    3e18:	68 f2 63 00 00       	push   $0x63f2
    3e1d:	6a 01                	push   $0x1
    3e1f:	e8 8c 04 00 00       	call   42b0 <printf>
}
    3e24:	83 c4 10             	add    $0x10,%esp
    3e27:	c9                   	leave
    3e28:	c3                   	ret
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3e29:	b8 09 00 00 00       	mov    $0x9,%eax
    3e2e:	ba 70 00 00 00       	mov    $0x70,%edx
    3e33:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3e34:	ba 71 00 00 00       	mov    $0x71,%edx
    3e39:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    3e3a:	52                   	push   %edx
    3e3b:	52                   	push   %edx
    3e3c:	68 f0 52 00 00       	push   $0x52f0
    3e41:	6a 01                	push   $0x1
    3e43:	e8 68 04 00 00       	call   42b0 <printf>
    exit();
    3e48:	e8 e6 02 00 00       	call   4133 <exit>
    printf (1, "fork failed\n");
    3e4d:	50                   	push   %eax
    3e4e:	50                   	push   %eax
    3e4f:	68 77 63 00 00       	push   $0x6377
    3e54:	6a 01                	push   $0x1
    3e56:	e8 55 04 00 00       	call   42b0 <printf>
    exit();
    3e5b:	e8 d3 02 00 00       	call   4133 <exit>

00003e60 <argptest>:
{
    3e60:	55                   	push   %ebp
    3e61:	89 e5                	mov    %esp,%ebp
    3e63:	53                   	push   %ebx
    3e64:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    3e67:	6a 00                	push   $0x0
    3e69:	68 01 64 00 00       	push   $0x6401
    3e6e:	e8 00 03 00 00       	call   4173 <open>
  if (fd < 0) {
    3e73:	83 c4 10             	add    $0x10,%esp
    3e76:	85 c0                	test   %eax,%eax
    3e78:	78 39                	js     3eb3 <argptest+0x53>
  read(fd, sbrk(0) - 1, -1);
    3e7a:	83 ec 0c             	sub    $0xc,%esp
    3e7d:	89 c3                	mov    %eax,%ebx
    3e7f:	6a 00                	push   $0x0
    3e81:	e8 35 03 00 00       	call   41bb <sbrk>
    3e86:	83 c4 0c             	add    $0xc,%esp
    3e89:	83 e8 01             	sub    $0x1,%eax
    3e8c:	6a ff                	push   $0xffffffff
    3e8e:	50                   	push   %eax
    3e8f:	53                   	push   %ebx
    3e90:	e8 b6 02 00 00       	call   414b <read>
  close(fd);
    3e95:	89 1c 24             	mov    %ebx,(%esp)
    3e98:	e8 be 02 00 00       	call   415b <close>
  printf(1, "arg test passed\n");
    3e9d:	58                   	pop    %eax
    3e9e:	5a                   	pop    %edx
    3e9f:	68 13 64 00 00       	push   $0x6413
    3ea4:	6a 01                	push   $0x1
    3ea6:	e8 05 04 00 00       	call   42b0 <printf>
}
    3eab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3eae:	83 c4 10             	add    $0x10,%esp
    3eb1:	c9                   	leave
    3eb2:	c3                   	ret
    printf(2, "open failed\n");
    3eb3:	51                   	push   %ecx
    3eb4:	51                   	push   %ecx
    3eb5:	68 06 64 00 00       	push   $0x6406
    3eba:	6a 02                	push   $0x2
    3ebc:	e8 ef 03 00 00       	call   42b0 <printf>
    exit();
    3ec1:	e8 6d 02 00 00       	call   4133 <exit>
    3ec6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3ecd:	00 
    3ece:	66 90                	xchg   %ax,%ax

00003ed0 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3ed0:	69 05 74 6e 00 00 0d 	imul   $0x19660d,0x6e74,%eax
    3ed7:	66 19 00 
    3eda:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3edf:	a3 74 6e 00 00       	mov    %eax,0x6e74
}
    3ee4:	c3                   	ret
    3ee5:	66 90                	xchg   %ax,%ax
    3ee7:	66 90                	xchg   %ax,%ax
    3ee9:	66 90                	xchg   %ax,%ax
    3eeb:	66 90                	xchg   %ax,%ax
    3eed:	66 90                	xchg   %ax,%ax
    3eef:	90                   	nop

00003ef0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3ef0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3ef1:	31 c0                	xor    %eax,%eax
{
    3ef3:	89 e5                	mov    %esp,%ebp
    3ef5:	53                   	push   %ebx
    3ef6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3ef9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3f00:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3f04:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3f07:	83 c0 01             	add    $0x1,%eax
    3f0a:	84 d2                	test   %dl,%dl
    3f0c:	75 f2                	jne    3f00 <strcpy+0x10>
    ;
  return os;
}
    3f0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3f11:	89 c8                	mov    %ecx,%eax
    3f13:	c9                   	leave
    3f14:	c3                   	ret
    3f15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3f1c:	00 
    3f1d:	8d 76 00             	lea    0x0(%esi),%esi

00003f20 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3f20:	55                   	push   %ebp
    3f21:	89 e5                	mov    %esp,%ebp
    3f23:	53                   	push   %ebx
    3f24:	8b 55 08             	mov    0x8(%ebp),%edx
    3f27:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    3f2a:	0f b6 02             	movzbl (%edx),%eax
    3f2d:	84 c0                	test   %al,%al
    3f2f:	75 17                	jne    3f48 <strcmp+0x28>
    3f31:	eb 3a                	jmp    3f6d <strcmp+0x4d>
    3f33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    3f38:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    3f3c:	83 c2 01             	add    $0x1,%edx
    3f3f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3f42:	84 c0                	test   %al,%al
    3f44:	74 1a                	je     3f60 <strcmp+0x40>
    3f46:	89 d9                	mov    %ebx,%ecx
    3f48:	0f b6 19             	movzbl (%ecx),%ebx
    3f4b:	38 c3                	cmp    %al,%bl
    3f4d:	74 e9                	je     3f38 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    3f4f:	29 d8                	sub    %ebx,%eax
}
    3f51:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3f54:	c9                   	leave
    3f55:	c3                   	ret
    3f56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3f5d:	00 
    3f5e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
    3f60:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3f64:	31 c0                	xor    %eax,%eax
    3f66:	29 d8                	sub    %ebx,%eax
}
    3f68:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3f6b:	c9                   	leave
    3f6c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
    3f6d:	0f b6 19             	movzbl (%ecx),%ebx
    3f70:	31 c0                	xor    %eax,%eax
    3f72:	eb db                	jmp    3f4f <strcmp+0x2f>
    3f74:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3f7b:	00 
    3f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003f80 <strlen>:

uint
strlen(const char *s)
{
    3f80:	55                   	push   %ebp
    3f81:	89 e5                	mov    %esp,%ebp
    3f83:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3f86:	80 3a 00             	cmpb   $0x0,(%edx)
    3f89:	74 15                	je     3fa0 <strlen+0x20>
    3f8b:	31 c0                	xor    %eax,%eax
    3f8d:	8d 76 00             	lea    0x0(%esi),%esi
    3f90:	83 c0 01             	add    $0x1,%eax
    3f93:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3f97:	89 c1                	mov    %eax,%ecx
    3f99:	75 f5                	jne    3f90 <strlen+0x10>
    ;
  return n;
}
    3f9b:	89 c8                	mov    %ecx,%eax
    3f9d:	5d                   	pop    %ebp
    3f9e:	c3                   	ret
    3f9f:	90                   	nop
  for(n = 0; s[n]; n++)
    3fa0:	31 c9                	xor    %ecx,%ecx
}
    3fa2:	5d                   	pop    %ebp
    3fa3:	89 c8                	mov    %ecx,%eax
    3fa5:	c3                   	ret
    3fa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    3fad:	00 
    3fae:	66 90                	xchg   %ax,%ax

00003fb0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3fb0:	55                   	push   %ebp
    3fb1:	89 e5                	mov    %esp,%ebp
    3fb3:	57                   	push   %edi
    3fb4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3fb7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3fba:	8b 45 0c             	mov    0xc(%ebp),%eax
    3fbd:	89 d7                	mov    %edx,%edi
    3fbf:	fc                   	cld
    3fc0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3fc2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3fc5:	89 d0                	mov    %edx,%eax
    3fc7:	c9                   	leave
    3fc8:	c3                   	ret
    3fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003fd0 <strchr>:

char*
strchr(const char *s, char c)
{
    3fd0:	55                   	push   %ebp
    3fd1:	89 e5                	mov    %esp,%ebp
    3fd3:	8b 45 08             	mov    0x8(%ebp),%eax
    3fd6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    3fda:	0f b6 10             	movzbl (%eax),%edx
    3fdd:	84 d2                	test   %dl,%dl
    3fdf:	75 12                	jne    3ff3 <strchr+0x23>
    3fe1:	eb 1d                	jmp    4000 <strchr+0x30>
    3fe3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    3fe8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    3fec:	83 c0 01             	add    $0x1,%eax
    3fef:	84 d2                	test   %dl,%dl
    3ff1:	74 0d                	je     4000 <strchr+0x30>
    if(*s == c)
    3ff3:	38 d1                	cmp    %dl,%cl
    3ff5:	75 f1                	jne    3fe8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3ff7:	5d                   	pop    %ebp
    3ff8:	c3                   	ret
    3ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    4000:	31 c0                	xor    %eax,%eax
}
    4002:	5d                   	pop    %ebp
    4003:	c3                   	ret
    4004:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    400b:	00 
    400c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00004010 <gets>:

char*
gets(char *buf, int max)
{
    4010:	55                   	push   %ebp
    4011:	89 e5                	mov    %esp,%ebp
    4013:	57                   	push   %edi
    4014:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    4015:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
    4018:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    4019:	31 db                	xor    %ebx,%ebx
{
    401b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    401e:	eb 27                	jmp    4047 <gets+0x37>
    cc = read(0, &c, 1);
    4020:	83 ec 04             	sub    $0x4,%esp
    4023:	6a 01                	push   $0x1
    4025:	56                   	push   %esi
    4026:	6a 00                	push   $0x0
    4028:	e8 1e 01 00 00       	call   414b <read>
    if(cc < 1)
    402d:	83 c4 10             	add    $0x10,%esp
    4030:	85 c0                	test   %eax,%eax
    4032:	7e 1d                	jle    4051 <gets+0x41>
      break;
    buf[i++] = c;
    4034:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    4038:	8b 55 08             	mov    0x8(%ebp),%edx
    403b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    403f:	3c 0a                	cmp    $0xa,%al
    4041:	74 10                	je     4053 <gets+0x43>
    4043:	3c 0d                	cmp    $0xd,%al
    4045:	74 0c                	je     4053 <gets+0x43>
  for(i=0; i+1 < max; ){
    4047:	89 df                	mov    %ebx,%edi
    4049:	83 c3 01             	add    $0x1,%ebx
    404c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    404f:	7c cf                	jl     4020 <gets+0x10>
    4051:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
    4053:	8b 45 08             	mov    0x8(%ebp),%eax
    4056:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
    405a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    405d:	5b                   	pop    %ebx
    405e:	5e                   	pop    %esi
    405f:	5f                   	pop    %edi
    4060:	5d                   	pop    %ebp
    4061:	c3                   	ret
    4062:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    4069:	00 
    406a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00004070 <stat>:

int
stat(const char *n, struct stat *st)
{
    4070:	55                   	push   %ebp
    4071:	89 e5                	mov    %esp,%ebp
    4073:	56                   	push   %esi
    4074:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4075:	83 ec 08             	sub    $0x8,%esp
    4078:	6a 00                	push   $0x0
    407a:	ff 75 08             	push   0x8(%ebp)
    407d:	e8 f1 00 00 00       	call   4173 <open>
  if(fd < 0)
    4082:	83 c4 10             	add    $0x10,%esp
    4085:	85 c0                	test   %eax,%eax
    4087:	78 27                	js     40b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    4089:	83 ec 08             	sub    $0x8,%esp
    408c:	ff 75 0c             	push   0xc(%ebp)
    408f:	89 c3                	mov    %eax,%ebx
    4091:	50                   	push   %eax
    4092:	e8 f4 00 00 00       	call   418b <fstat>
  close(fd);
    4097:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    409a:	89 c6                	mov    %eax,%esi
  close(fd);
    409c:	e8 ba 00 00 00       	call   415b <close>
  return r;
    40a1:	83 c4 10             	add    $0x10,%esp
}
    40a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    40a7:	89 f0                	mov    %esi,%eax
    40a9:	5b                   	pop    %ebx
    40aa:	5e                   	pop    %esi
    40ab:	5d                   	pop    %ebp
    40ac:	c3                   	ret
    40ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    40b0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    40b5:	eb ed                	jmp    40a4 <stat+0x34>
    40b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    40be:	00 
    40bf:	90                   	nop

000040c0 <atoi>:

int
atoi(const char *s)
{
    40c0:	55                   	push   %ebp
    40c1:	89 e5                	mov    %esp,%ebp
    40c3:	53                   	push   %ebx
    40c4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    40c7:	0f be 02             	movsbl (%edx),%eax
    40ca:	8d 48 d0             	lea    -0x30(%eax),%ecx
    40cd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    40d0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    40d5:	77 1e                	ja     40f5 <atoi+0x35>
    40d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    40de:	00 
    40df:	90                   	nop
    n = n*10 + *s++ - '0';
    40e0:	83 c2 01             	add    $0x1,%edx
    40e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    40e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    40ea:	0f be 02             	movsbl (%edx),%eax
    40ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
    40f0:	80 fb 09             	cmp    $0x9,%bl
    40f3:	76 eb                	jbe    40e0 <atoi+0x20>
  return n;
}
    40f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    40f8:	89 c8                	mov    %ecx,%eax
    40fa:	c9                   	leave
    40fb:	c3                   	ret
    40fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00004100 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    4100:	55                   	push   %ebp
    4101:	89 e5                	mov    %esp,%ebp
    4103:	57                   	push   %edi
    4104:	8b 45 10             	mov    0x10(%ebp),%eax
    4107:	8b 55 08             	mov    0x8(%ebp),%edx
    410a:	56                   	push   %esi
    410b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    410e:	85 c0                	test   %eax,%eax
    4110:	7e 13                	jle    4125 <memmove+0x25>
    4112:	01 d0                	add    %edx,%eax
  dst = vdst;
    4114:	89 d7                	mov    %edx,%edi
    4116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    411d:	00 
    411e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
    4120:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    4121:	39 f8                	cmp    %edi,%eax
    4123:	75 fb                	jne    4120 <memmove+0x20>
  return vdst;
}
    4125:	5e                   	pop    %esi
    4126:	89 d0                	mov    %edx,%eax
    4128:	5f                   	pop    %edi
    4129:	5d                   	pop    %ebp
    412a:	c3                   	ret

0000412b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    412b:	b8 01 00 00 00       	mov    $0x1,%eax
    4130:	cd 40                	int    $0x40
    4132:	c3                   	ret

00004133 <exit>:
SYSCALL(exit)
    4133:	b8 02 00 00 00       	mov    $0x2,%eax
    4138:	cd 40                	int    $0x40
    413a:	c3                   	ret

0000413b <wait>:
SYSCALL(wait)
    413b:	b8 03 00 00 00       	mov    $0x3,%eax
    4140:	cd 40                	int    $0x40
    4142:	c3                   	ret

00004143 <pipe>:
SYSCALL(pipe)
    4143:	b8 04 00 00 00       	mov    $0x4,%eax
    4148:	cd 40                	int    $0x40
    414a:	c3                   	ret

0000414b <read>:
SYSCALL(read)
    414b:	b8 05 00 00 00       	mov    $0x5,%eax
    4150:	cd 40                	int    $0x40
    4152:	c3                   	ret

00004153 <write>:
SYSCALL(write)
    4153:	b8 10 00 00 00       	mov    $0x10,%eax
    4158:	cd 40                	int    $0x40
    415a:	c3                   	ret

0000415b <close>:
SYSCALL(close)
    415b:	b8 15 00 00 00       	mov    $0x15,%eax
    4160:	cd 40                	int    $0x40
    4162:	c3                   	ret

00004163 <kill>:
SYSCALL(kill)
    4163:	b8 06 00 00 00       	mov    $0x6,%eax
    4168:	cd 40                	int    $0x40
    416a:	c3                   	ret

0000416b <exec>:
SYSCALL(exec)
    416b:	b8 07 00 00 00       	mov    $0x7,%eax
    4170:	cd 40                	int    $0x40
    4172:	c3                   	ret

00004173 <open>:
SYSCALL(open)
    4173:	b8 0f 00 00 00       	mov    $0xf,%eax
    4178:	cd 40                	int    $0x40
    417a:	c3                   	ret

0000417b <mknod>:
SYSCALL(mknod)
    417b:	b8 11 00 00 00       	mov    $0x11,%eax
    4180:	cd 40                	int    $0x40
    4182:	c3                   	ret

00004183 <unlink>:
SYSCALL(unlink)
    4183:	b8 12 00 00 00       	mov    $0x12,%eax
    4188:	cd 40                	int    $0x40
    418a:	c3                   	ret

0000418b <fstat>:
SYSCALL(fstat)
    418b:	b8 08 00 00 00       	mov    $0x8,%eax
    4190:	cd 40                	int    $0x40
    4192:	c3                   	ret

00004193 <link>:
SYSCALL(link)
    4193:	b8 13 00 00 00       	mov    $0x13,%eax
    4198:	cd 40                	int    $0x40
    419a:	c3                   	ret

0000419b <mkdir>:
SYSCALL(mkdir)
    419b:	b8 14 00 00 00       	mov    $0x14,%eax
    41a0:	cd 40                	int    $0x40
    41a2:	c3                   	ret

000041a3 <chdir>:
SYSCALL(chdir)
    41a3:	b8 09 00 00 00       	mov    $0x9,%eax
    41a8:	cd 40                	int    $0x40
    41aa:	c3                   	ret

000041ab <dup>:
SYSCALL(dup)
    41ab:	b8 0a 00 00 00       	mov    $0xa,%eax
    41b0:	cd 40                	int    $0x40
    41b2:	c3                   	ret

000041b3 <getpid>:
SYSCALL(getpid)
    41b3:	b8 0b 00 00 00       	mov    $0xb,%eax
    41b8:	cd 40                	int    $0x40
    41ba:	c3                   	ret

000041bb <sbrk>:
SYSCALL(sbrk)
    41bb:	b8 0c 00 00 00       	mov    $0xc,%eax
    41c0:	cd 40                	int    $0x40
    41c2:	c3                   	ret

000041c3 <sleep>:
SYSCALL(sleep)
    41c3:	b8 0d 00 00 00       	mov    $0xd,%eax
    41c8:	cd 40                	int    $0x40
    41ca:	c3                   	ret

000041cb <uptime>:
SYSCALL(uptime)
    41cb:	b8 0e 00 00 00       	mov    $0xe,%eax
    41d0:	cd 40                	int    $0x40
    41d2:	c3                   	ret

000041d3 <shmget>:
SYSCALL(shmget)
    41d3:	b8 16 00 00 00       	mov    $0x16,%eax
    41d8:	cd 40                	int    $0x40
    41da:	c3                   	ret

000041db <shmat>:
SYSCALL(shmat)
    41db:	b8 17 00 00 00       	mov    $0x17,%eax
    41e0:	cd 40                	int    $0x40
    41e2:	c3                   	ret

000041e3 <shmdt>:
SYSCALL(shmdt)
    41e3:	b8 18 00 00 00       	mov    $0x18,%eax
    41e8:	cd 40                	int    $0x40
    41ea:	c3                   	ret

000041eb <shmctl>:
SYSCALL(shmctl)
    41eb:	b8 19 00 00 00       	mov    $0x19,%eax
    41f0:	cd 40                	int    $0x40
    41f2:	c3                   	ret

000041f3 <shminfo>:
SYSCALL(shminfo)
    41f3:	b8 1a 00 00 00       	mov    $0x1a,%eax
    41f8:	cd 40                	int    $0x40
    41fa:	c3                   	ret

000041fb <removeshm>:
SYSCALL(removeshm)
    41fb:	b8 1b 00 00 00       	mov    $0x1b,%eax
    4200:	cd 40                	int    $0x40
    4202:	c3                   	ret
    4203:	66 90                	xchg   %ax,%ax
    4205:	66 90                	xchg   %ax,%ax
    4207:	66 90                	xchg   %ax,%ax
    4209:	66 90                	xchg   %ax,%ax
    420b:	66 90                	xchg   %ax,%ax
    420d:	66 90                	xchg   %ax,%ax
    420f:	90                   	nop

00004210 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    4210:	55                   	push   %ebp
    4211:	89 e5                	mov    %esp,%ebp
    4213:	57                   	push   %edi
    4214:	56                   	push   %esi
    4215:	53                   	push   %ebx
    4216:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    4218:	89 d1                	mov    %edx,%ecx
{
    421a:	83 ec 3c             	sub    $0x3c,%esp
    421d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
    4220:	85 d2                	test   %edx,%edx
    4222:	0f 89 80 00 00 00    	jns    42a8 <printint+0x98>
    4228:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    422c:	74 7a                	je     42a8 <printint+0x98>
    x = -xx;
    422e:	f7 d9                	neg    %ecx
    neg = 1;
    4230:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
    4235:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    4238:	31 f6                	xor    %esi,%esi
    423a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    4240:	89 c8                	mov    %ecx,%eax
    4242:	31 d2                	xor    %edx,%edx
    4244:	89 f7                	mov    %esi,%edi
    4246:	f7 f3                	div    %ebx
    4248:	8d 76 01             	lea    0x1(%esi),%esi
    424b:	0f b6 92 b8 64 00 00 	movzbl 0x64b8(%edx),%edx
    4252:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
    4256:	89 ca                	mov    %ecx,%edx
    4258:	89 c1                	mov    %eax,%ecx
    425a:	39 da                	cmp    %ebx,%edx
    425c:	73 e2                	jae    4240 <printint+0x30>
  if(neg)
    425e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    4261:	85 c0                	test   %eax,%eax
    4263:	74 07                	je     426c <printint+0x5c>
    buf[i++] = '-';
    4265:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
    426a:	89 f7                	mov    %esi,%edi
    426c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    426f:	8b 75 c0             	mov    -0x40(%ebp),%esi
    4272:	01 df                	add    %ebx,%edi
    4274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    4278:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    427b:	83 ec 04             	sub    $0x4,%esp
    427e:	88 45 d7             	mov    %al,-0x29(%ebp)
    4281:	8d 45 d7             	lea    -0x29(%ebp),%eax
    4284:	6a 01                	push   $0x1
    4286:	50                   	push   %eax
    4287:	56                   	push   %esi
    4288:	e8 c6 fe ff ff       	call   4153 <write>
  while(--i >= 0)
    428d:	89 f8                	mov    %edi,%eax
    428f:	83 c4 10             	add    $0x10,%esp
    4292:	83 ef 01             	sub    $0x1,%edi
    4295:	39 c3                	cmp    %eax,%ebx
    4297:	75 df                	jne    4278 <printint+0x68>
}
    4299:	8d 65 f4             	lea    -0xc(%ebp),%esp
    429c:	5b                   	pop    %ebx
    429d:	5e                   	pop    %esi
    429e:	5f                   	pop    %edi
    429f:	5d                   	pop    %ebp
    42a0:	c3                   	ret
    42a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    42a8:	31 c0                	xor    %eax,%eax
    42aa:	eb 89                	jmp    4235 <printint+0x25>
    42ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000042b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    42b0:	55                   	push   %ebp
    42b1:	89 e5                	mov    %esp,%ebp
    42b3:	57                   	push   %edi
    42b4:	56                   	push   %esi
    42b5:	53                   	push   %ebx
    42b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    42b9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    42bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    42bf:	0f b6 1e             	movzbl (%esi),%ebx
    42c2:	83 c6 01             	add    $0x1,%esi
    42c5:	84 db                	test   %bl,%bl
    42c7:	74 67                	je     4330 <printf+0x80>
    42c9:	8d 4d 10             	lea    0x10(%ebp),%ecx
    42cc:	31 d2                	xor    %edx,%edx
    42ce:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    42d1:	eb 34                	jmp    4307 <printf+0x57>
    42d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    42d8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    42db:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    42e0:	83 f8 25             	cmp    $0x25,%eax
    42e3:	74 18                	je     42fd <printf+0x4d>
  write(fd, &c, 1);
    42e5:	83 ec 04             	sub    $0x4,%esp
    42e8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    42eb:	88 5d e7             	mov    %bl,-0x19(%ebp)
    42ee:	6a 01                	push   $0x1
    42f0:	50                   	push   %eax
    42f1:	57                   	push   %edi
    42f2:	e8 5c fe ff ff       	call   4153 <write>
    42f7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    42fa:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    42fd:	0f b6 1e             	movzbl (%esi),%ebx
    4300:	83 c6 01             	add    $0x1,%esi
    4303:	84 db                	test   %bl,%bl
    4305:	74 29                	je     4330 <printf+0x80>
    c = fmt[i] & 0xff;
    4307:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    430a:	85 d2                	test   %edx,%edx
    430c:	74 ca                	je     42d8 <printf+0x28>
      }
    } else if(state == '%'){
    430e:	83 fa 25             	cmp    $0x25,%edx
    4311:	75 ea                	jne    42fd <printf+0x4d>
      if(c == 'd'){
    4313:	83 f8 25             	cmp    $0x25,%eax
    4316:	0f 84 04 01 00 00    	je     4420 <printf+0x170>
    431c:	83 e8 63             	sub    $0x63,%eax
    431f:	83 f8 15             	cmp    $0x15,%eax
    4322:	77 1c                	ja     4340 <printf+0x90>
    4324:	ff 24 85 60 64 00 00 	jmp    *0x6460(,%eax,4)
    432b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    4330:	8d 65 f4             	lea    -0xc(%ebp),%esp
    4333:	5b                   	pop    %ebx
    4334:	5e                   	pop    %esi
    4335:	5f                   	pop    %edi
    4336:	5d                   	pop    %ebp
    4337:	c3                   	ret
    4338:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    433f:	00 
  write(fd, &c, 1);
    4340:	83 ec 04             	sub    $0x4,%esp
    4343:	8d 55 e7             	lea    -0x19(%ebp),%edx
    4346:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    434a:	6a 01                	push   $0x1
    434c:	52                   	push   %edx
    434d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    4350:	57                   	push   %edi
    4351:	e8 fd fd ff ff       	call   4153 <write>
    4356:	83 c4 0c             	add    $0xc,%esp
    4359:	88 5d e7             	mov    %bl,-0x19(%ebp)
    435c:	6a 01                	push   $0x1
    435e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    4361:	52                   	push   %edx
    4362:	57                   	push   %edi
    4363:	e8 eb fd ff ff       	call   4153 <write>
        putc(fd, c);
    4368:	83 c4 10             	add    $0x10,%esp
      state = 0;
    436b:	31 d2                	xor    %edx,%edx
    436d:	eb 8e                	jmp    42fd <printf+0x4d>
    436f:	90                   	nop
        printint(fd, *ap, 16, 0);
    4370:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    4373:	83 ec 0c             	sub    $0xc,%esp
    4376:	b9 10 00 00 00       	mov    $0x10,%ecx
    437b:	8b 13                	mov    (%ebx),%edx
    437d:	6a 00                	push   $0x0
    437f:	89 f8                	mov    %edi,%eax
        ap++;
    4381:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    4384:	e8 87 fe ff ff       	call   4210 <printint>
        ap++;
    4389:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    438c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    438f:	31 d2                	xor    %edx,%edx
    4391:	e9 67 ff ff ff       	jmp    42fd <printf+0x4d>
        s = (char*)*ap;
    4396:	8b 45 d0             	mov    -0x30(%ebp),%eax
    4399:	8b 18                	mov    (%eax),%ebx
        ap++;
    439b:	83 c0 04             	add    $0x4,%eax
    439e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    43a1:	85 db                	test   %ebx,%ebx
    43a3:	0f 84 87 00 00 00    	je     4430 <printf+0x180>
        while(*s != 0){
    43a9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    43ac:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    43ae:	84 c0                	test   %al,%al
    43b0:	0f 84 47 ff ff ff    	je     42fd <printf+0x4d>
    43b6:	8d 55 e7             	lea    -0x19(%ebp),%edx
    43b9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    43bc:	89 de                	mov    %ebx,%esi
    43be:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
    43c0:	83 ec 04             	sub    $0x4,%esp
    43c3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    43c6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    43c9:	6a 01                	push   $0x1
    43cb:	53                   	push   %ebx
    43cc:	57                   	push   %edi
    43cd:	e8 81 fd ff ff       	call   4153 <write>
        while(*s != 0){
    43d2:	0f b6 06             	movzbl (%esi),%eax
    43d5:	83 c4 10             	add    $0x10,%esp
    43d8:	84 c0                	test   %al,%al
    43da:	75 e4                	jne    43c0 <printf+0x110>
      state = 0;
    43dc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    43df:	31 d2                	xor    %edx,%edx
    43e1:	e9 17 ff ff ff       	jmp    42fd <printf+0x4d>
        printint(fd, *ap, 10, 1);
    43e6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    43e9:	83 ec 0c             	sub    $0xc,%esp
    43ec:	b9 0a 00 00 00       	mov    $0xa,%ecx
    43f1:	8b 13                	mov    (%ebx),%edx
    43f3:	6a 01                	push   $0x1
    43f5:	eb 88                	jmp    437f <printf+0xcf>
        putc(fd, *ap);
    43f7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    43fa:	83 ec 04             	sub    $0x4,%esp
    43fd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    4400:	8b 03                	mov    (%ebx),%eax
        ap++;
    4402:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    4405:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    4408:	6a 01                	push   $0x1
    440a:	52                   	push   %edx
    440b:	57                   	push   %edi
    440c:	e8 42 fd ff ff       	call   4153 <write>
        ap++;
    4411:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    4414:	83 c4 10             	add    $0x10,%esp
      state = 0;
    4417:	31 d2                	xor    %edx,%edx
    4419:	e9 df fe ff ff       	jmp    42fd <printf+0x4d>
    441e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    4420:	83 ec 04             	sub    $0x4,%esp
    4423:	88 5d e7             	mov    %bl,-0x19(%ebp)
    4426:	8d 55 e7             	lea    -0x19(%ebp),%edx
    4429:	6a 01                	push   $0x1
    442b:	e9 31 ff ff ff       	jmp    4361 <printf+0xb1>
    4430:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    4435:	bb 57 64 00 00       	mov    $0x6457,%ebx
    443a:	e9 77 ff ff ff       	jmp    43b6 <printf+0x106>
    443f:	90                   	nop

00004440 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4440:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4441:	a1 40 b6 00 00       	mov    0xb640,%eax
{
    4446:	89 e5                	mov    %esp,%ebp
    4448:	57                   	push   %edi
    4449:	56                   	push   %esi
    444a:	53                   	push   %ebx
    444b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    444e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4458:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    445a:	39 c8                	cmp    %ecx,%eax
    445c:	73 32                	jae    4490 <free+0x50>
    445e:	39 d1                	cmp    %edx,%ecx
    4460:	72 04                	jb     4466 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4462:	39 d0                	cmp    %edx,%eax
    4464:	72 32                	jb     4498 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    4466:	8b 73 fc             	mov    -0x4(%ebx),%esi
    4469:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    446c:	39 fa                	cmp    %edi,%edx
    446e:	74 30                	je     44a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    4470:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    4473:	8b 50 04             	mov    0x4(%eax),%edx
    4476:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    4479:	39 f1                	cmp    %esi,%ecx
    447b:	74 3a                	je     44b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    447d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    447f:	5b                   	pop    %ebx
  freep = p;
    4480:	a3 40 b6 00 00       	mov    %eax,0xb640
}
    4485:	5e                   	pop    %esi
    4486:	5f                   	pop    %edi
    4487:	5d                   	pop    %ebp
    4488:	c3                   	ret
    4489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4490:	39 d0                	cmp    %edx,%eax
    4492:	72 04                	jb     4498 <free+0x58>
    4494:	39 d1                	cmp    %edx,%ecx
    4496:	72 ce                	jb     4466 <free+0x26>
{
    4498:	89 d0                	mov    %edx,%eax
    449a:	eb bc                	jmp    4458 <free+0x18>
    449c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    44a0:	03 72 04             	add    0x4(%edx),%esi
    44a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    44a6:	8b 10                	mov    (%eax),%edx
    44a8:	8b 12                	mov    (%edx),%edx
    44aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    44ad:	8b 50 04             	mov    0x4(%eax),%edx
    44b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    44b3:	39 f1                	cmp    %esi,%ecx
    44b5:	75 c6                	jne    447d <free+0x3d>
    p->s.size += bp->s.size;
    44b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    44ba:	a3 40 b6 00 00       	mov    %eax,0xb640
    p->s.size += bp->s.size;
    44bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    44c2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    44c5:	89 08                	mov    %ecx,(%eax)
}
    44c7:	5b                   	pop    %ebx
    44c8:	5e                   	pop    %esi
    44c9:	5f                   	pop    %edi
    44ca:	5d                   	pop    %ebp
    44cb:	c3                   	ret
    44cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000044d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    44d0:	55                   	push   %ebp
    44d1:	89 e5                	mov    %esp,%ebp
    44d3:	57                   	push   %edi
    44d4:	56                   	push   %esi
    44d5:	53                   	push   %ebx
    44d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    44d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    44dc:	8b 15 40 b6 00 00    	mov    0xb640,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    44e2:	8d 78 07             	lea    0x7(%eax),%edi
    44e5:	c1 ef 03             	shr    $0x3,%edi
    44e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    44eb:	85 d2                	test   %edx,%edx
    44ed:	0f 84 8d 00 00 00    	je     4580 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    44f3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    44f5:	8b 48 04             	mov    0x4(%eax),%ecx
    44f8:	39 f9                	cmp    %edi,%ecx
    44fa:	73 64                	jae    4560 <malloc+0x90>
  if(nu < 4096)
    44fc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    4501:	39 df                	cmp    %ebx,%edi
    4503:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    4506:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    450d:	eb 0a                	jmp    4519 <malloc+0x49>
    450f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4510:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    4512:	8b 48 04             	mov    0x4(%eax),%ecx
    4515:	39 f9                	cmp    %edi,%ecx
    4517:	73 47                	jae    4560 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4519:	89 c2                	mov    %eax,%edx
    451b:	3b 05 40 b6 00 00    	cmp    0xb640,%eax
    4521:	75 ed                	jne    4510 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    4523:	83 ec 0c             	sub    $0xc,%esp
    4526:	56                   	push   %esi
    4527:	e8 8f fc ff ff       	call   41bb <sbrk>
  if(p == (char*)-1)
    452c:	83 c4 10             	add    $0x10,%esp
    452f:	83 f8 ff             	cmp    $0xffffffff,%eax
    4532:	74 1c                	je     4550 <malloc+0x80>
  hp->s.size = nu;
    4534:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    4537:	83 ec 0c             	sub    $0xc,%esp
    453a:	83 c0 08             	add    $0x8,%eax
    453d:	50                   	push   %eax
    453e:	e8 fd fe ff ff       	call   4440 <free>
  return freep;
    4543:	8b 15 40 b6 00 00    	mov    0xb640,%edx
      if((p = morecore(nunits)) == 0)
    4549:	83 c4 10             	add    $0x10,%esp
    454c:	85 d2                	test   %edx,%edx
    454e:	75 c0                	jne    4510 <malloc+0x40>
        return 0;
  }
}
    4550:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    4553:	31 c0                	xor    %eax,%eax
}
    4555:	5b                   	pop    %ebx
    4556:	5e                   	pop    %esi
    4557:	5f                   	pop    %edi
    4558:	5d                   	pop    %ebp
    4559:	c3                   	ret
    455a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    4560:	39 cf                	cmp    %ecx,%edi
    4562:	74 4c                	je     45b0 <malloc+0xe0>
        p->s.size -= nunits;
    4564:	29 f9                	sub    %edi,%ecx
    4566:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    4569:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    456c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    456f:	89 15 40 b6 00 00    	mov    %edx,0xb640
}
    4575:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    4578:	83 c0 08             	add    $0x8,%eax
}
    457b:	5b                   	pop    %ebx
    457c:	5e                   	pop    %esi
    457d:	5f                   	pop    %edi
    457e:	5d                   	pop    %ebp
    457f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    4580:	c7 05 40 b6 00 00 44 	movl   $0xb644,0xb640
    4587:	b6 00 00 
    base.s.size = 0;
    458a:	b8 44 b6 00 00       	mov    $0xb644,%eax
    base.s.ptr = freep = prevp = &base;
    458f:	c7 05 44 b6 00 00 44 	movl   $0xb644,0xb644
    4596:	b6 00 00 
    base.s.size = 0;
    4599:	c7 05 48 b6 00 00 00 	movl   $0x0,0xb648
    45a0:	00 00 00 
    if(p->s.size >= nunits){
    45a3:	e9 54 ff ff ff       	jmp    44fc <malloc+0x2c>
    45a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    45af:	00 
        prevp->s.ptr = p->s.ptr;
    45b0:	8b 08                	mov    (%eax),%ecx
    45b2:	89 0a                	mov    %ecx,(%edx)
    45b4:	eb b9                	jmp    456f <malloc+0x9f>
