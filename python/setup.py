from setuptools import setup

setup(
    name='karps',
    version='0.2.0',
    packages=['karps', 'karps.functions_std', 'karps.proto'],
    install_requires=['grpcio', 'pandas', 'six', 'future', 'tensorflow'],
    author="Timothy Hunter",
    author_email="tjhunter@cs.stanford.edu",
    license='Apache 2.0',
    long_description=open('README.md').read(),
)